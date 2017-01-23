import Foundation


// class for containing the start or end of a button press
class ButtonPacket: NSObject, NSCoding
{
    // are we signalling the beginning of a press or the end?
    var isPressEnd: Bool!
    
    
    
    // init for when we are decoded upon receiving
    required convenience init(coder decoder: NSCoder)
    {
        self.init()
        
        // set to decoded value
        self.isPressEnd = decoder.decodeObject(forKey: "state") as! Bool
    }
    
    
    // copy init
    convenience init(isPressEnd: Bool)
    {
        self.init()
        self.isPressEnd = isPressEnd
    }
    
    
    // encode value for sending over the network
    public func encode(with coder: NSCoder)
    {
        coder.encode(isPressEnd,  forKey: "state")
    }
}
