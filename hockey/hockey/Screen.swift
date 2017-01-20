import SpriteKit




//enum for each game screen
enum ScreenType: String
{
    case Start      = "start",
         Main       = "main",
         TeamSelect = "team",
         Game       = "game",
         End        = "end"
}





class Screen: Entity
{
    let name:String
    
    
    
    
    
    init(name:ScreenType)
    {
        self.name = name.rawValue

        super.init()
    }
    
    init(name:String, transitionTo:String)
    {
        self.name = name
        
        super.init()
        
        //let transition = ChangeScreen(transitionTo)
        //components.append(transition)
    }
}
