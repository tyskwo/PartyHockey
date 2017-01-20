import SpriteKit





class GameScene: SKScene
{
    //delta time
    private var lastUpdateTime: TimeInterval = 0
    
    //current screen being represented
    var currentScreen: Screen

    
    
    
    
    //set start screen, dimensions, bg color. turn off gravity and set anchor point to center.
    override init()
    {
        currentScreen = MainScreen()
        
        super.init(size: CGSize(width: 1920, height: 1080))
        
        self.backgroundColor = SKColor.init(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
        self.physicsWorld.gravity = CGVector.zero
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    
    

    
    //update all components
    override func update(_ currentTime: TimeInterval)
    {
        //perform initial setup for start screen, set current time
        if (self.lastUpdateTime == 0)
        {
            initialSetup()
            self.lastUpdateTime = currentTime
        }
        
        let dt = currentTime - self.lastUpdateTime
        
        currentScreen.update(dt: dt)
        
        self.lastUpdateTime = currentTime
    }
    
    
    
    
    
    //add NodeComponents to screen
    private func initialSetup()
    {
        (currentScreen as! MainScreen).setup()
    }
    
    func receive(event: Event)
    {
        (currentScreen as Entity).receive(event: event)
    }
    
    
}






extension GameScene
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        SiriRemoteHandler.touchesBegan(touches, withEvent: event!)
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?)
    {
        SiriRemoteHandler.pressesBegan(presses, withEvent: event!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        SiriRemoteHandler.touchesEnded(touches, withEvent: event!)
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?)
    {
        SiriRemoteHandler.pressesEnded(presses, withEvent: event!)
    }

}
