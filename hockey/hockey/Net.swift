import SpriteKit





class Net: Component
{
    var net:    SKSpriteNode
    var inside: SKSpriteNode
    
    var animations: [Animation] = []

    
    
    
    init(entity: Entity, name: String, tag: String, net: SKSpriteNode, inside: SKSpriteNode)
    {
        self.net    = net
        self.inside = inside
        
        self.net.physicsBody = SKPhysicsBody(texture: self.net.texture!, size: self.net.size)
        self.net.physicsBody!.isDynamic = false
        self.net.physicsBody!.usesPreciseCollisionDetection = true
        self.net.physicsBody!.contactTestBitMask = 1

        super.init(entity: entity, name: name, tag: tag)
    }
    
    convenience init(entity: Entity, name: String, tag: String, rinkName: String)
    {
        let rink = SKScene(fileNamed: "rink_" + rinkName)!
        
        var net_temp:   SKSpriteNode!
        var inside_temp: SKSpriteNode!
        
        if(tag == "blue")
        {
            net_temp    = rink.childNode(withName: "net_blue")! as! SKSpriteNode
            inside_temp = rink.childNode(withName: "net_blue_inside")! as! SKSpriteNode
        }
        else
        {
            net_temp    = rink.childNode(withName: "net_red")! as! SKSpriteNode
            inside_temp = rink.childNode(withName: "net_red_inside")! as! SKSpriteNode
        }
        
        self.init(entity: entity, name: name, tag: tag, net: net_temp, inside: inside_temp)
    }
}










extension Net: Renderable
{
    func addToScene()
    {
        scene.addChild(net)
        scene.addChild(inside)
    }
    
    func get() -> SKNode
    {
        return net
    }
    
    func destroy()
    {
        net.removeFromParent()
        inside.removeFromParent()
    }
}










extension Net //Goal detection
{
    func checkGoal(puckPosition: CGPoint) -> Bool
    {
        return inside.contains(puckPosition)
    }
}
