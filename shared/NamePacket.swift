import Foundation
import SpriteKit


// class for containing the name of a device
class NamePacket: NSObject, NSCoding
{
    // who are we?
    var name: String!
    
    
    
    // init for when we are decoded upon receiving
    required convenience init(coder decoder: NSCoder)
    {
        self.init()
        
        // set to decoded value
        self.name = decoder.decodeObject(forKey: "name") as! String
    }
    
    
    // copy init
    convenience init(name: String)
    {
        self.init()
        self.name = name
    }
    
    
    // encode value for sending over the network
    public func encode(with coder: NSCoder)
    {
        coder.encode(name, forKey: "name")
    }
}
