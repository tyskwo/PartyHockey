import SpriteKit





class Faceoff: Component
{
    //place players in correct spots: for player in entity.findAllOf(component: Player.self) { player.setFaceoff() }
    var isFinished = false

    
    
    
    
    override init(entity: Entity, name: String, tag: String)
    {
        super.init(entity: entity, name: name, tag: tag)
        
        countdown()
    }
    
    
    
    
    
    func createText() -> SKLabelNode
    {
        let countdown = SKLabelNode(text: "3")
        countdown.fontName                   = "JosefinSans-Bold"
        countdown.fontSize                   = 320
        countdown.fontColor                  = Colors.gray
        countdown.horizontalAlignmentMode    = .center
        countdown.verticalAlignmentMode      = .center
        countdown.zPosition = 10
        
        countdown.position = entity.find(component: Rink.self)!.puckPosition
        
        countdown.horizontalAlignmentMode = .center
        countdown.verticalAlignmentMode   = .center
        
        return countdown
    }
}









extension Faceoff //countdown
{
    func countdown()
    {
        stopUserInteraction()
        //currentMenu.touchBegin = nil
        
        
        let countdown = createText()
        
        scene.addChild(countdown)
        
        
        var wait = SKAction.wait(forDuration: 1.0)
        var changeTo = SKAction.run({ countdown.text = "2" })
        
        
        countdown.run(SKAction.sequence([wait, changeTo]), completion:
        {
            changeTo = SKAction.run({ countdown.text = "1" })
            
            countdown.run(SKAction.sequence([wait, changeTo]), completion:
            {
                changeTo = SKAction.run({ countdown.text = "GO!" })

                countdown.run(SKAction.sequence([wait, changeTo]), completion:
                {
                    self.resumeUserInteraction()
                    
                    self.isFinished = true
                    
                    //if(fromGame)
                    //{
                    //    Globals.startTimer = true
                    //}
                    
                    self.entity.find(component: Timer.self)!.start()
                    
                    wait = SKAction.wait(forDuration: 0.5)
                    changeTo = SKAction.run({ countdown.removeFromParent() })
                    
                    countdown.run(SKAction.sequence([wait, changeTo]))
                })
            })
        })
    }
}










extension Faceoff //user interaction, start/finish
{
    func stopUserInteraction()
    {
        MovementControls.canMove = false
    }
    
    func resumeUserInteraction()
    {
        MovementControls.canMove = true
    }
    
    func hasFinished() -> Bool
    {
        return isFinished
    }
    
    func reset()
    {
        isFinished = false
    }
}
