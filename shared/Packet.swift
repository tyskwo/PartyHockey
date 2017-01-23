import Foundation


// class that defines a packet for talking across the network
class Packet: NSObject, NSCoding
{
    // the object we are encapsulating in the packet, and what type of packet we are
    var objectType: ObjectType!
    var object: AnyObject!
    
    
    
    // init for when we are decoded upon receiving
    required convenience init(coder decoder: NSCoder)
    {
        self.init()
        let temp_type:Int = decoder.decodeInteger(forKey: "object_type")
        objectType = ObjectType(rawValue: temp_type)

        
        object = decoder.decodeObject(forKey: "object") as! NSObject
    }
    
    
    // copy init
    convenience init(objectType: ObjectType, object: AnyObject)
    {
        self.init()
        self.objectType = objectType
        self.object = object
    }
    
    
    // encode value for sending over the network
    func encode(with coder: NSCoder)
    {
        let type:Int = objectType.rawValue
        coder.encode(type,   forKey: "object_type")
        coder.encode(object, forKey: "object") 
    }
    
    
    // get object as an element
    func getObject<Element>() -> Element
    {
        return object as! Element
    }
}



enum ObjectType: Int
{
    case TouchPacket  = 1,
         ButtonPacket = 2,
         NamePacket   = 3
}
