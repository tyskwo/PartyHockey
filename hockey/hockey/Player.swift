import SpriteKit





class Player: Component
{
    enum Control
    {
        case SiriRemote, PhoneRemote, AI
    }
    var type:Control
    
    var node:SKSpriteNode
    var halo:SKSpriteNode
    var puck:Puck? = nil
    
    var index = 1
    
    let movementControls = MovementControls()
    
    
    
    var spawnTEMP:CGPoint = CGPoint.zero

    //AI module
    //pickup puck
    //shoot
    //check
    
    var animations: [Animation] = []

    
    //init with position, team, AI/human control?
    
    init(entity: Entity, name: String, tag: String, info: (CGPoint, String, Int))
    {
        if name.contains("red")
        {
            node = SKSpriteNode(imageNamed: "red_player")
            halo = SKSpriteNode(imageNamed: "red_player_halo")

        }
        else
        {
            node = SKSpriteNode(imageNamed: "blue_player")
            halo = SKSpriteNode(imageNamed: "blue_player_halo")
        }
        node.position = info.0
        node.zPosition = 15
        halo.alpha = 0
        halo.zPosition = -1
        node.addChild(halo)
        
        index = info.2
        type = .SiriRemote
        spawnTEMP = info.0
        
        node.physicsBody = SKPhysicsBody(circleOfRadius: node.texture!.size().width / 2)
        node.physicsBody!.usesPreciseCollisionDetection = true
        node.physicsBody!.isDynamic = true
        node.physicsBody!.linearDamping = 0.98
        node.physicsBody!.contactTestBitMask = 1

        super.init(entity: entity, name: name, tag: tag)
        
        movementControls.set(player: self)
    }
    
    
    func addPuck(_ pPuck:Puck)
    {
        puck = pPuck
        puck!.attach(to: self)
        
        //puck!.resetPoints()
        
        puck!.node.position = CGPoint.zero
        puck!.node.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
        
        puck!.node.physicsBody!.pinned = true
    }

    func removePuck()
    {
        puck = nil
    }
    
    func losePuck(checkerPosition: CGPoint, checkerVelocity: CGVector)
    {
        /*let deltaX = checkerPosition.x - position.x
        let deltaY = checkerPosition.y - position.y
        let delta = sqrt(deltaX*deltaX + deltaY*deltaY)
        let radius:CGFloat = 72.5 /*radius + puck radius + 5 padding*/
        puck!.position = CGPoint(x: position.x - CGFloat(radius * deltaX/delta), y: position.y - CGFloat(radius * deltaY/delta))
    
    
        if(scene.physicsWorld.body(at: puck!.node.position) == nil)
        {
            puck!.node.position = checkerPposition
            puck!n.node.physicsBody!.velocity = CGVector(dx: 0,dy: 0)
        }*/
    
        puck!.node.physicsBody!.velocity = CGVector(dx: checkerVelocity.dx / 10, dy: checkerVelocity.dy / 10)
        puck!.node.position = self.node.position
        
        puck!.detach(from: self)
    }
    
    func shoot(with deltas: (x:CGFloat, y:CGFloat))
    {
        let delta = sqrt(pow(deltas.x, 2) + pow(deltas.y, 2))
        let xPos = node.position.x + CGFloat(35 /*player radius + puck radius + 5 padding*/ * deltas.x/delta)
        let yPos = node.position.y - CGFloat(35 /*player radius + puck radius + 5 padding*/ * deltas.y/delta)
        
        puck!.node.position = node.position
        node.position = CGPoint(x: xPos, y: yPos)
        
        puck!.node.physicsBody!.pinned = false
        puck!.node.physicsBody!.velocity = CGVector(dx: -deltas.x, dy: deltas.y)
        
        puck!.detach(from: self)
    }
}




extension Player: Updateable
{
    func update(_ dt: Double)
    {
        movementControls.update()
    }
}










extension Player: Renderable
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










extension Player: Animatable
{
    func setup()
    {
        
    }
    
    func transitionIn (duration: TimeInterval)
    {
        
    }
    
    func transitionOut(duration: TimeInterval)
    {
        
    }
}










extension Player: GoalResetComponent
{
    func reset()
    {
        puck?.detach(from: self)
        
        node.position = spawnTEMP
        node.physicsBody!.velocity = CGVector.zero
    }
}
