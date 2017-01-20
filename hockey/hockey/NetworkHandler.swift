


class NetworkHandler: NSObject, NetServiceDelegate, GCDAsyncSocketDelegate
{
    var service: NetService?
    var services = [NetService]()
    var socket: GCDAsyncSocket!
    var sockets: [GCDAsyncSocket] = []
    
    
    
    
    func startBroadcast()
    {
        socket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
        
        do
        {
            try socket.accept(onPort: 0)
            service = NetService(domain: "", type: "_game._tcp", name: "DASHockey", port: Int32(socket.localPort))
        } catch { print("error listening on port") }
        
        if let service = service
        {
            service.delegate = self
            service.publish()
        }
    }
    
    
    
    func netServiceDidPublish(_ sender: NetService)
    {
        guard let service = service else { return }
        
        print("published succesfully on port \(service.port) / domain: \(service.domain) / \(service.type) / \(service.name)")
    }
    
    
    
    func socket(_ sock: GCDAsyncSocket, didAcceptNewSocket newSocket: GCDAsyncSocket)
    {
        //http://stackoverflow.com/questions/25297436/gcdasyncsocket-multiple-connections
        print("Socket accepted")
        sockets.append(newSocket)
        //socket = newSocket
        //socket.delegate = self
        //print(newSocket.connectedPort)
        
        let screen = (scene as! GameScene).currentScreen
        
        (screen as! MainScreen).addNewPlayer()
        
        newSocket.readData(toLength: UInt(MemoryLayout<UInt64>.size), withTimeout: -1, tag: 0)
    }
    
    
    
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int)
    {
        if tag == 0
        {
            let data: NSData! = data as NSData!
            
            let count = data.length / MemoryLayout<UInt8>.size
            
            // create an array of Uint8
            var array = [UInt8](repeating: 0, count: count)
            
            // copy bytes into array
            data.getBytes(&array, length:count * MemoryLayout<UInt8>.size)
            
            var bodyLength: UInt64 = 0
            memcpy(&bodyLength, &array, MemoryLayout<UInt64>.size);

            
            print("Header received with bodylength: \(bodyLength)")
            socket.readData(toLength: UInt(bodyLength), withTimeout: -1, tag: 1)
        }
        else if tag == 1
        {
            let packet = NSKeyedUnarchiver.unarchiveObject(with: data) as! Packet
            PacketHandler.Receive(packet: packet)
            socket.readData(toLength: UInt(MemoryLayout<UInt64>.size), withTimeout: -1, tag: 0)
        }
    }
    
    
    
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?)
    {
        if (socket == sock)
        {
            print("Socket disconnected")
            socket.delegate = nil
            socket = nil
        }
    }
}
