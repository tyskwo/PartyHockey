import Foundation
import SpriteKit

class NetworkHandler: NSObject, NetServiceDelegate, NetServiceBrowserDelegate, GCDAsyncSocketDelegate
{
    // the socket we are attached to
    var socket: GCDAsyncSocket!
    
    // the servers we can find
    var services: NSMutableArray!
    
    // the browser to help us find servers
    var serviceBrowser: NetServiceBrowser!
    
    // the server we connect to
    var service: NetService!
    
    
    // called on app start
    func startBrowsing()
    {
        // if somehow services is already populated, clear it
        if (services != nil) services.removeAllObjects()
        else                 services = NSMutableArray()
        
        // create a new browser and start looking for servers
        serviceBrowser = NetServiceBrowser()
        serviceBrowser.delegate = self
        serviceBrowser.searchForServices(ofType: "_game._tcp", inDomain: "")
    }
    
    
    // called when a server is found
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool)
    {
        // add it to the list and connect to it
        services.add(service)
        connect()
    }
    
    
    func connect()
    {
        // create connection with server
        service = services.firstObject! as! NetService
        service.delegate = self
        service.resolve(withTimeout: -1.0)
    }
    
    
    // called when we can't connect to address
    func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber])
    {
        service.delegate = nil
    }

    
    // called when we were able to conect to address
    func netServiceDidResolveAddress(_ sender: NetService)
    {
        if connect(withService: sender) print("Did connect with service")
        else                            print("Error connecting with service")
    }
    
    
    // called when we can connect to server, initializes connection
    func connect(withService: NetService) -> Bool
    {
        var isConnected = false
        
        // get valid addresses
        let addresses: NSArray = service.addresses! as NSArray
        
        // if we're not connected yet
        if (socket == nil || !socket.isConnected)
        {
            // create a socket
            socket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
            var count = 0
            
            // and try to connect to all valid sockets
            while (!isConnected && addresses.count >= count)
            {
                let address = addresses.object(at: count) as! Data
                count += 1
                do
                {
                    try socket.connect(toAddress: address)
                    isConnected = true
                } catch { print("Failed to connect") }
            }
        }
            
        // we connected!
        else isConnected = socket.isConnected
        
        return isConnected
    }
    
    
    // called to tell host we connected
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16)
    {
        print("Socket connected to host")
        
        // send name packet with device name
        let namePacket = NamePacket(name: UIDevice.current.name)
        let packet = Packet(objectType: .NamePacket, object: namePacket)
        
        send(packet: packet)
    }
    
    
    // called to send a packet
    func send(packet: Packet)
    {
        // get packet data, create a buffer, write packet data to buffer
        let packetData = NSKeyedArchiver.archivedData(withRootObject: packet)
        var packetDataLength = packetData.count
        let buffer = NSMutableData(bytes: &packetDataLength, length: MemoryLayout<UInt64>.size)
        buffer.append(packetData)
        
        // write buffer to socket
        if socket != nil { socket.write(buffer as Data, withTimeout: -1, tag: 0) }
    }
}
