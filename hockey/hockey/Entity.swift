class Entity
{
    var components:[Component]
    
    private var name:String
    private var tag: String?
    
    
    
    init()
    {
        components = []
        name = "NONE"
    }
    
    init(name:String)
    {
        components = []
        
        self.name   = name
    }
    
    init(name:String, tag:String)
    {
        components = []
        
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





extension Entity
{
    func add(component:Component)
    {
        components.append(component)
    }
    
    /// update all components that conform to UpdateableComponent
    func update(dt: Double)
    {
        for item in components where item is Updateable
        {
            (item as! Updateable).update(dt)
        }
    }
    
    /// destroy all components that conform to NodeComponent
    func destroy()
    {
        for item in components where item is Renderable
        {
            (item as! Renderable).destroy()
        }
    }
    
    /// animate in/out all components that conform to AnimateableComponent
    func animate(`in`: TimeInterval)
    {
        
        for item in components where item is Renderable
        {
            (item as! Renderable).addToScene()
        }
        
        for item in components where item is Animatable
        {
            (item as! Animatable).setup()
            
            (item as! Animatable).transitionIn(duration: `in`)
        }
    }
    
    func animate(out: TimeInterval)
    {
        for item in components where item is Animatable
        {
            (item as! Animatable).transitionOut(duration: out)
        }
    }
    
    func receive(event: Event)
    {
        for item in components
        {
            if item is EventListener
            {
                (item as! EventListener).receive(event: event)
            }
        }
    }
}





//Search methods
extension Entity
{
    /// get first component of type T
    func find<T>(component: T.Type) -> T?
    {
        for item in components
        {
            if item is T
            {
                return (item as! T)
            }
        }
        
        return nil
    }
    
    /// get all components of type T
    func findAllOf<T>(component: T.Type) -> [T]
    {
        var returnArray:[T] = []
        
        for item in components
        {
            if item is T
            {
                returnArray.append(item as! T)
            }
        }
        
        return returnArray
    }
}
