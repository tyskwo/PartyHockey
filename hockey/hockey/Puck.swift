import SpriteKit





class Puck: Component
{
    var node = SKSpriteNode()
    
    var animations: [Animation] = []
    
    
    override init(entity:Entity, name: String)
    {
        super.init(entity: entity, name: name)
        
        node = SKSpriteNode(imageNamed: "puck")
        
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.texture!.size().width / 2)
        node.physicsBody!.usesPreciseCollisionDetection = true
        node.physicsBody!.isDynamic = true
        node.physicsBody!.restitution = 0.4
        
        node.physicsBody!.contactTestBitMask = 1
        
        node.zPosition = 15
    }
    
    convenience init(entity: Entity, name: String, position: CGPoint)
    {
        self.init(entity: entity, name: name)
        
        node.position = position
    }
    
    func attach(to player: Player)
    {
        node.removeFromParent()
        player.node.addChild(self.node)
    }
    
    func detach(from player: Player)
    {
        self.node.removeFromParent()
        node.physicsBody!.pinned = false

        player.removePuck()
        addToScene()
    }
}










extension Puck: Renderable
{
    func addToScene()
    {
        scene.addChild(node)
    }
    
    func get() -> SKNode
    {
        return node
    }
    
    func destroy()
    {
        node.removeFromParent()
    }
}










extension Puck: Animatable
{
    func setup()
    {
        node.alpha = 0
    }
    
    func transitionIn(duration: TimeInterval)
    {
        let fade = SKAction.fadeIn(withDuration: duration)
        fade.timingFunction = TimingFunctions.CircularEaseOut
        
        node.run(fade)
    }
    
    func transitionOut(duration: TimeInterval)
    {
        let fade = SKAction.fadeOut(withDuration: duration)
        fade.timingFunction = TimingFunctions.CircularEaseOut
        
        node.run(fade)
    }
}




extension Puck: Updateable
{
    func update(_ dt: Double)
    {
    }
}






extension Puck: GoalScoredComponent
{
    func goalScored(team: String)
    {
        node.physicsBody!.friction = 0.6
    }
}










extension Puck: GoalResetComponent
{
    func reset()
    {        
        node.physicsBody!.friction = 0.2
        node.physicsBody!.velocity = CGVector.zero
        node.position = CGPoint.zero
    }
}
