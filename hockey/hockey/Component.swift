import Foundation
import SpriteKit





class Component
{
    let entity: Entity
    
    private var name:String
    private var tag: String?
    
    
    
    init(entity: Entity)
    {
        self.entity = entity
        self.name = "NONE"
    }
    
    init(entity: Entity, name:String)
    {
        self.entity = entity

        self.name   = name
    }
    
    init(entity: Entity, name:String, tag:String)
    {
        self.entity = entity

        self.name   = name
        self.tag    = tag
    }
    
    
    
    
    func set(tag:String)
    {
        self.tag = tag
    }
    
    func set(name:String)
    {
        self.name = name
    }
    
    func getTag() -> String
    {
        return self.tag ?? "NONE"
    }
    
    func getName() -> String
    {
        return self.name
    }
}










protocol Updateable
{
    func update(_ dt: Double)
}

protocol Renderable
{
    func addToScene()
    func get() -> SKNode
    func destroy()
}

protocol Animatable
{
    var animations: [Animation] { get set }
    
    func setup()
    func transitionIn (duration: TimeInterval)
    func transitionOut(duration: TimeInterval)
}

protocol EventListener
{
    func receive(event: Event)
}








protocol GoalScoredComponent
{
    func goalScored(team: String)
}
protocol GoalResetComponent
{
    func reset()
}
