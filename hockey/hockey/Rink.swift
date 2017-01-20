import SpriteKit




class Rink: Component
{
    var scorePositions = (blue: CGPoint.zero, red: CGPoint.zero)
    var timerPosition = CGPoint.zero
    var puckPosition  = CGPoint.zero
    var faceoffPositions: [(CGPoint, String, Int)] = []
    
    var rink:SKNode
    
    var boards:SKRegion!
    
    var goalScored = false
    
    //if the rink animates in/out as one entity, the current set up is fine.
    //if the rink should animate each piece individually, need to store references to each part
    
    var animations: [Animation] = []
    
    init(entity: Entity, name: String, rinkType: String)
    {
        //grab the rink file
        let rinkScene = SKScene(fileNamed: "rink_" + rinkType)!
        
        //set the reference
        rink = rinkScene.childNode(withName: "rink")!
        
        //grab the boards node
        let boards = rink.childNode(withName: "boards")! as! SKSpriteNode
        
        //create the physicsbody from the boards inverse SVG in game assets, thank you PocketSVG
        var edgeLoop = PocketSVG.path(fromSVGFileNamed: "antiboards_" + rinkType).takeUnretainedValue()
        
        var translation = CGAffineTransform(translationX: -(CGFloat)(0), y: -(CGFloat)(0))
        edgeLoop = edgeLoop.copy(using: &translation)!
        //var rotation = CGAffineTransform(rotationAngle: 180)
        //edgeLoop = edgeLoop.copy(using: &rotation)!

        boards.physicsBody = SKPhysicsBody(edgeLoopFrom: edgeLoop)
        boards.physicsBody!.usesPreciseCollisionDetection = true
        
        self.boards = SKRegion(path: edgeLoop)
        
        //set positions from reference nodes in the scene
        scorePositions = (rink.childNode(withName: "score_red" )!.position,
                          rink.childNode(withName: "score_blue")!.position)
        timerPosition  =  rink.childNode(withName: "timer"     )!.position
        puckPosition   =  rink.childNode(withName: "puck"      )!.position
        
        
        for node in rink.children
        {
            if node.name?.contains("faceoff") ?? false
            {
                print("TEST")
                
                var team = "red"
                if node.name!.contains("blue")
                {
                    team = "blue"
                }
                
                var order = 0
                if(node.name!.contains("1"))
                {
                    order = 1
                }
                
                faceoffPositions.append((node.position, team, order))
            }
        }
        
        super.init(entity: entity, name: name)
    }
    
    
    
    
    
    func goalScored(net: Net)
    {
        goalScored = true
        
        let score = SKAction.run({
            for c in self.entity.findAllOf(component: GoalScoredComponent.self)
            {
                c.goalScored(team: net.getTag())
            }
        })
        
        let reset = SKAction.run({
            for c in self.entity.findAllOf(component: GoalResetComponent.self)
            {
                c.reset()
            }
        })
        
        let wait = SKAction.wait(forDuration: 5) //global goal celebration length
        
        let sequence = SKAction.sequence([score, wait, reset])
        
        scene.run(sequence, completion: {
            self.goalScored = false
            self.entity.add(component: Faceoff(entity: self.entity, name: "faceoff", tag: "UI"))
        })
    }
}




extension Rink: EventListener
{
    func receive(event: Event)
    {
        var eventAnimations: [SKAction] = []
        for animation in animations where animation is Gettable
        {
            let animation = (animation as! Gettable).get(forEvent: event)
            
            if animation != nil
            {
                eventAnimations.append(animation!)
            }
        }
        
        SKAction.group(eventAnimations)
    }
}








extension Rink: Renderable
{
    func addToScene()
    {
        scene.addChild(rink)
    }
    
    func get() -> SKNode
    {
        return rink
    }

    func destroy()
    {
        rink.removeFromParent()
    }
}









extension Rink: Animatable
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










extension Rink: Updateable
{
    func update(_ dt: Double)
    {
        if !goalScored
        {
            let puck = entity.find(component: Puck.self)!
            
            for net in entity.findAllOf(component: Net.self)
            {
                if(net.checkGoal(puckPosition: scene.convert(puck.node.position, to: scene)) ||
                  (puck.node.parent != nil && net.checkGoal(puckPosition: scene.convert((puck.node.parent?.position)!, to: scene))))
                {
                    goalScored(net: net)
                }
            }
        }
    }
}










extension Rink: GoalScoredComponent
{
    func goalScored(team: String)
    {
        if team == "red"
        {
            scene.backgroundColor = .red
        }
        else if team == "blue"
        {
            scene.backgroundColor = .blue
        }
    }
}

extension Rink: GoalResetComponent
{
    func reset()
    {
        scene.backgroundColor = .white
    }
}
