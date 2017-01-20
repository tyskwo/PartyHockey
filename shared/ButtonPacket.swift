import Foundation
import SpriteKit

@objc(ButtonPacket)
class ButtonPacket: NSObject, NSCoding
{
    var isPressEnd: Bool!
    
    required convenience init(coder decoder: NSCoder)
    {
        self.init()
        
        self.isPressEnd = decoder.decodeObject(forKey: "state") as! Bool
    }
    
    convenience init(isPressEnd: Bool)
    {
        self.init()
        self.isPressEnd = isPressEnd
    }
    
    public func encode(with coder: NSCoder)
    {
        coder.encode(isPressEnd,  forKey: "state")
    }
}
