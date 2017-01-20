import SpriteKit





class Timer: Component
{
    //reference to label node, amount of time in seconds, and whether or not the timer is paused
    let text = SKLabelNode()
    var time:CGFloat = 60
    var isRunning = false
    
    var animations: [Animation] = []

    
    //initialize with only a position
    init(entity:Entity, name:String, position:CGPoint)
    {
        super.init(entity: entity, name: name)
        
        
        text.position = position
    }
    
    //initialize with position and tag
    init(entity:Entity, name:String, tag:String, position:CGPoint)
    {
        super.init(entity: entity, name: name, tag: tag)
        
        
        text.position = position
    }
    
    //initialize with time and tag
    init(entity:Entity, name:String, tag:String, time:CGFloat)
    {
        super.init(entity: entity, name: name, tag: tag)
        
        
        self.time = time
    }
    
    //initialize with position and time
    convenience init(entity:Entity, name:String, position:CGPoint, time:CGFloat)
    {
        self.init(entity: entity, name: name, position: position)
        
        
        self.time = time
        
        self.stylize()
    }
    
    //initialize with position, time, and tag
    convenience init(entity:Entity, name:String, tag:String, position:CGPoint, time:CGFloat)
    {
        self.init(entity: entity, name: name, tag: tag, position: position)
        
        
        self.time = time
        
        self.stylize()
    }
    
    
    
    
    
    //set the correct font, color, weight, size, etc.
    func stylize()
    {
        text.fontName                   = "JosefinSans-Bold"
        text.fontSize                   = 320
        text.fontColor                  = Colors.gray
        text.horizontalAlignmentMode    = .center
        text.verticalAlignmentMode      = .center
        
        
        text.zPosition = 10
        
        text.text = "TIMER"
    }
    
    //start the timer
    func start()
    {
        isRunning = true
    }
    
    //pause the timer
    func pause()
    {
        isRunning = false
    }
}










extension Timer: Updateable
{
    //subtract time from timer and update text
    func update(_ dt: Double)
    {
        if isRunning
        {
            time -= CGFloat(dt)
        }
        
        let minute = Int(time) / 60
        let second = Int(time) % 60
        
        if(second < 10)
        {
            text.text = "\(minute):0\(second)"
        }
        else
        {
            text.text = "\(minute):\(second)"
        }
    }
}










extension Timer: Renderable
{
    func addToScene()
    {
        scene.addChild(text)
    }
    
    func get() -> SKNode
    {
        return text
    }
    
    func destroy()
    {
        text.removeFromParent()
    }
}









extension Timer: Animatable
{
    func setup()
    {
        text.alpha = 0
    }
    
    func transitionIn(duration: TimeInterval)
    {
        let fade = SKAction.fadeIn(withDuration: duration)
        fade.timingFunction = TimingFunctions.CircularEaseOut

        text.run(fade)
    }
    
    func transitionOut(duration: TimeInterval)
    {
        //nothing for now.
    }
}










extension Timer: GoalScoredComponent
{
    func goalScored(team: String)
    {
        pause()
    }
}
