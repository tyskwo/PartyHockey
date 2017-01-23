import Foundation
import SpriteKit



// class for containing the position of a touch
class TouchPacket: NSObject, NSCoding
{
    // where are we?
    var position: (x: CGFloat, y: CGFloat)!
    
    // are we signalling the beginning of a press or the end?
    var isTouchEnd: Bool!
    
    
    
    // init for when we are decoded upon receiving
    required convenience init(coder decoder: NSCoder)
    {
        self.init()

        // set to decoded value
        self.position   = (decoder.decodeObject(forKey: "position_x") as! CGFloat,
                           decoder.decodeObject(forKey: "position_y") as! CGFloat)
        self.isTouchEnd =  decoder.decodeObject(forKey: "state") as! Bool
    }
    
    
    // copy init
    convenience init(position_x: CGFloat, position_y: CGFloat, isTouchEnd: Bool)
    {
        self.init()
        self.position = (position_x, position_y)
        self.isTouchEnd = isTouchEnd
    }
    
    
    // encode value for sending over the network
    public func encode(with coder: NSCoder)
    {
        coder.encode(position.x, forKey: "position_x")
        coder.encode(position.y, forKey: "position_y")
        coder.encode(isTouchEnd, forKey: "state")
    }
}
