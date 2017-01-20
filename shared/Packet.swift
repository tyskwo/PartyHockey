import Foundation

@objc(Packet)
class Packet: NSObject, NSCoding
{
    var objectType: ObjectType!
    var object: AnyObject!
    
    required convenience init(coder decoder: NSCoder)
    {
        self.init()
        let temp_type:Int = decoder.decodeInteger(forKey: "object_type")
        objectType = ObjectType(rawValue: temp_type)

        
        object = decoder.decodeObject(forKey: "object") as! NSObject
    }
    
    convenience init(objectType: ObjectType, object: AnyObject)
    {
        self.init()
        self.objectType = objectType
        self.object = object
    }
    
    func encode(with coder: NSCoder)
    {
        let type:Int = objectType.rawValue
        coder.encode(type,   forKey: "object_type")
        coder.encode(object, forKey: "object") 
    }
    
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
