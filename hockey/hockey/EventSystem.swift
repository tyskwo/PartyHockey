struct Event
{
    enum `Type`
    {
        case AnimateIn, AnimateOut, GoalScored, FaceOff
    }
    
    var type:Type
    
    init(type: Type)
    {
        self.type = type
    }
}


class EventSystem
{
    static func send(event: Event)
    {
        (scene as! GameScene).receive(event: event)
    }
}
