import UIKit
import SpriteKit
import GameplayKit




// globals for scene and scene dimensions
var scene:SKScene!

let WIDTH  = 1920, HALFWIDTH  = 960,
    HEIGHT = 1080, HALFHEIGHT = 540


var networkHandler: NetworkHandler!



class GameViewController: UIViewController
{
    //present scene, draw debug options
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let view = self.view as! SKView?
        {
            scene = GameScene()

            scene.scaleMode = .resizeFill
            
            NotificationCenter.default.addObserver(SiriRemoteHandler.self,
                                                   selector: #selector(SiriRemoteHandler.gameControllerDidConnect(notification:)),
                                                   name: NSNotification.Name.GCControllerDidConnect,
                                                   object: nil)
            
            NotificationCenter.default.addObserver(SiriRemoteHandler.self,
                                                   selector: #selector(SiriRemoteHandler.gameControllerDidDisconnect(notification:)),
                                                   name: NSNotification.Name.GCControllerDidDisconnect,
                                                   object: nil)

            networkHandler = NetworkHandler()
            networkHandler.startBroadcast()
            
            view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            view.drawDebug()
            
        }
    }
}









//extension for drawing debug options
extension SKView
{
    func drawDebug()
    {
        self.showsFPS       = true
        self.showsNodeCount = true
        self.showsQuadCount = false
        self.showsDrawCount = true
        self.showsPhysics   = true
        self.showsFields    = true
    }
}





extension SKView
{
    override open func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?)
    {
        var shouldQuit = false
        for item in presses
        {
            if(item.type == .menu)
            {
                shouldQuit = true
            }
        }
        
        if(shouldQuit && ((scene as! GameScene).currentScreen is MainScreen))
        {
            super.pressesBegan(presses, with: event)
        }
        else
        {
            (scene as! GameScene).pressesBegan(presses, with: event)
        }
    }
    
    override open func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?)
    {
        (scene as! GameScene).pressesEnded(presses, with: event)
    }

}
