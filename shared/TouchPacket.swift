import Foundation
import SpriteKit

@objc(TouchPacket)
class TouchPacket: NSObject, NSCoding
{
    var position: (x: CGFloat, y: CGFloat)!
    var isTouchEnd: Bool!
    
    required convenience init(coder decoder: NSCoder)
    {
        self.init()

        self.position   = (decoder.decodeObject(forKey: "position_x") as! CGFloat, decoder.decodeObject(forKey: "position_y") as! CGFloat)
        self.isTouchEnd =  decoder.decodeObject(forKey: "state") as! Bool
    }
    
    convenience init(position_x: CGFloat, position_y: CGFloat, isTouchEnd: Bool)
    {
        self.init()
        self.position = (position_x, position_y)
        self.isTouchEnd = isTouchEnd
    }
    
    public func encode(with coder: NSCoder)
    {
        coder.encode(position.x, forKey: "position_x")
        coder.encode(position.y, forKey: "position_y")
        coder.encode(isTouchEnd, forKey: "state")
    }
}
