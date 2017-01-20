import GameController

class SiriRemoteHandler: NSObject
{
    static var gamePad: GCMicroGamepad?
    
    static var isMenuPressed = false
    
    
    static func gameControllerDidConnect(notification : Notification)
    {
        if let controller = notification.object as? GCController
        {
            if let mGPad = controller.microGamepad
            {
                gamePad = mGPad
                gamePad!.allowsRotation = true
                gamePad!.reportsAbsoluteDpadValues = true
            }
        }
    }
    
    static func gameControllerDidDisconnect(notification : Notification)
    {
        if let controller = notification.object as? GCController
        {
            if  controller.microGamepad != nil
            {
                gamePad = nil
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    static func pressesBegan(_ presses: Set<UIPress>, withEvent event: UIPressesEvent)
    {
        for item in presses
        {
            if item.type == .playPause
            {
                (scene as! GameScene).currentScreen.find(component: Player.self)?.movementControls.pressedA(true)
            }
            if item.type == .menu
            {
                SiriRemoteHandler.isMenuPressed = true
            }
        }
    }
    
    static func pressesEnded(_ presses: Set<UIPress>, withEvent event: UIPressesEvent)
    {
        for item in presses
        {
            if item.type == .playPause
            {
                (scene as! GameScene).currentScreen.find(component: Player.self)?.movementControls.pressedA(false)
            }
            if item.type == .menu
            {
                SiriRemoteHandler.isMenuPressed = false
            }
        }
    }

    
    
    static func touchesBegan(_ touches: Set<NSObject>, withEvent event: UIEvent)
    {
        let touch:UITouch = touches.first! as! UITouch
        let positionInScene = touch.location(in: scene)
        print(positionInScene)
        (scene as! GameScene).currentScreen.find(component: Player.self)?.movementControls.touchBegin = positionInScene
        (scene as! GameScene).currentScreen.find(component: Player.self)?.movementControls.touchEnd   = nil
    }
    
    static func touchesEnded(_ touches: Set<NSObject>, withEvent event: UIEvent)
    {
        let touch:UITouch = touches.first! as! UITouch
        var positionInScene = touch.location(in: scene)
        
        positionInScene.x /= 1920.0
        positionInScene.y /= 1080.0
        
        (scene as! GameScene).currentScreen.find(component: Player.self)?.movementControls.touchEnd = positionInScene
    }
}
