import SpriteKit





class Score: Component
{
    let textRed  = SKLabelNode()
    let textBlue = SKLabelNode()
    
    var scoreRed = 0, scoreBlue = 0
    
    
    var animations: [Animation] = []

    
    
    init(entity:Entity, name: String, red:CGPoint, blue:CGPoint)
    {
        super.init(entity: entity, name: name)
        
        textRed.position  = red
        textBlue.position = blue
        
        stylize()
    }
    
    
    
    
    
    private func stylize()
    {
        for text in [textBlue, textRed]
        {
            text.fontName                   = "JosefinSans-Bold"
            text.fontSize                   = 320
            text.horizontalAlignmentMode    = .center
            text.verticalAlignmentMode      = .center
            text.zPosition = 10
        }
        
        scoreRed = 23
        textBlue.fontColor = Colors.blue
        textRed.fontColor = Colors.red

    }
    
    func addToRed()
    {
        scoreRed += 1
    }
    
    func addToBlue()
    {
        scoreBlue += 1
    }
}










extension Score: Renderable
{
    func addToScene()
    {
        scene.addChild(textBlue)
        scene.addChild(textRed)
    }
    
    func get() -> SKNode { return SKNode() }
    
    func destroy()
    {
        textBlue.removeFromParent()
        textRed .removeFromParent()
    }
}










extension Score: Updateable
{
    func update(_ dt: Double)
    {
        textRed.text  = "\(scoreRed)"
        textBlue.text = "\(scoreBlue)"
    }
}










extension Score: Animatable
{
    func setup()
    {
        textRed.alpha  = 0
        textBlue.alpha = 0
        
        textRed.setScale (5)
        textBlue.setScale(5)
    }
    
    func transitionIn(duration: TimeInterval)
    {
        let fade = SKAction.fadeIn(withDuration: duration)
        fade.timingFunction = TimingFunctions.CircularEaseOut
        
        let scale = SKAction.scale(to: 1, duration: duration)
        scale.timingFunction = TimingFunctions.CircularEaseOut
        
        let combo = SKAction.group([fade, scale])
        
        textRed.run (combo)
        textBlue.run(combo)
    }
    
    func transitionOut(duration: TimeInterval)
    {
        
    }
}










extension Score: GoalScoredComponent
{
    func goalScored(team: String)
    {
        if team == "red"
        {
            scoreRed += 1
        }
            
        else if team == "blue"
        {
            scoreBlue += 1
        }
    }
}
