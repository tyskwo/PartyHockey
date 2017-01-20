import Foundation
import SpriteKit

class NetworkHandler: NSObject, NetServiceDelegate, NetServiceBrowserDelegate, GCDAsyncSocketDelegate
{
    var socket: GCDAsyncSocket!
    var services: NSMutableArray!
    var serviceBrowser: NetServiceBrowser!
    var service: NetService!
    
    
    
    func startBrowsing()
    {
        if (services != nil)
        {
            services.removeAllObjects()
        }
        else
        {
            services = NSMutableArray()
        }
        
        serviceBrowser = NetServiceBrowser()
        serviceBrowser.delegate = self
        serviceBrowser.searchForServices(ofType: "_game._tcp", inDomain: "")
    }
    
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool)
    {
        services.add(service)
        connect()
    }
    
    
    func connect()
    {
        service = services.firstObject! as! NetService
        service.delegate = self
        service.resolve(withTimeout: -1.0)
    }
    
    func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber])
    {
        service.delegate = nil
    }

    
    func netServiceDidResolveAddress(_ sender: NetService)
    {
        if connect(withService: sender)
        {
            print("Did connect with service")
        }
        else
        {
            print("Error connecting with service")
        }
    }
    
    func connect(withService: NetService) -> Bool
    {
        var isConnected = false
        
        let addresses: NSArray = service.addresses! as NSArray
        
        if (socket == nil || !socket.isConnected)
        {
            socket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
            var count = 0
            
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
        else
        {
            isConnected = socket.isConnected
        }
        
        return isConnected
    }
    
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16)
    {
        print("Socket connected to host")
        let namePacket = NamePacket(name: UIDevice.current.name)
        let packet = Packet(objectType: .NamePacket, object: namePacket)
        
        send(packet: packet)
    }
    
    
    func send(packet: Packet)
    {
        let packetData = NSKeyedArchiver.archivedData(withRootObject: packet)
        var packetDataLength = packetData.count
        let buffer = NSMutableData(bytes: &packetDataLength, length: MemoryLayout<UInt64>.size)
        buffer.append(packetData)
        
        if socket != nil { socket.write(buffer as Data, withTimeout: -1, tag: 0) }
    }
}
