import SpriteKit

class Pause: Component
{
    //pause game
    //bring up menu
    //let player one control menu
    
    //take appropriate action (change screen)
    
    var animations: [Animation] = []

    
    override init(entity:Entity, name:String)
    {
        super.init(entity: entity, name: name)
        
        pause()
    }
    
    override init(entity:Entity, name:String, tag:String)
    {
        super.init(entity: entity, name: name, tag: tag)
        
        pause()
    }

    
    
    func pause()
    {
        scene.physicsWorld.speed = 0
        
        transitionIn(duration: 1.5)
    }
}







extension Pause: Renderable
{
    func addToScene()
    {
        //scene.addChild(textRed)
    }
    
    func get() -> SKNode { return SKNode() }
    
    func destroy()
    {
        //textRed .removeFromParent()
    }
}










extension Pause: Animatable
{
    func setup()
    {

    }
    
    func transitionIn(duration: TimeInterval)
    {

    }
    
    func transitionOut(duration: TimeInterval)
    {
        
    }
}

