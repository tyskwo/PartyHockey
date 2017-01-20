import Foundation
import SpriteKit

@objc(NamePacket)
class NamePacket: NSObject, NSCoding
{
    var name: String!
    
    required convenience init(coder decoder: NSCoder)
    {
        self.init()
        
        self.name = decoder.decodeObject(forKey: "name") as! String
    }
    
    convenience init(name: String)
    {
        self.init()
        self.name = name
    }
    
    public func encode(with coder: NSCoder)
    {
        coder.encode(name, forKey: "name")
    }
}
