import SpriteKit





class MainScreen: Screen
{
    let rinkName = "curl"
    
    
    
    
    
    init()
    {
        super.init(name: ScreenType.Main)
        
        components.append(Rink(entity: self, name: "rink", rinkType: rinkName))
        
        addNets()
        addPuck()
        addPlayers()
        addUI()
    }
    
    
    
    
    //add all game components.
    func setup()
    {
        //transition in, and upon completion start the faceoff.
        let duration = 2.5
        let wait = SKAction.wait(forDuration: duration)
        let transitionIn = SKAction.run({ self.animate(in: duration) })
        let sequence = SKAction.sequence([transitionIn, wait])
        
        scene.run(sequence, completion: { self.startFaceoff() })
    }
    
    
    
    
    
    private func addNets()
    {
        components.append(Net(entity: self, name: "net", tag: "blue", rinkName: rinkName))
        components.append(Net(entity: self, name: "net", tag: "red",  rinkName: rinkName))
    }
    
    
    
    
    
    private func addPuck()
    {
        let rink = find(component: Rink.self)!
        
        components.append(Puck(entity: self, name: "puck", position: rink.puckPosition))
    }
    
    
    
    
    
    private func addUI()
    {
        let rink = find(component: Rink.self)!

        
        components.append(Timer(entity: self, name: "timer", tag: "UI", position: rink.timerPosition, time: 600))
        
        components.append(Score(entity: self, name: "score", red:  rink.scorePositions.red,
                                                             blue: rink.scorePositions.blue))
    }
    
    
    
    
    
    private func addPlayers()
    {
        let rink = find(component: Rink.self)!
        components.append(Player(entity: self, name: "player_red_1", tag: "main_player", info: rink.faceoffPositions[0]))
    }
    
    func addNewPlayer()
    {
        let rink = find(component: Rink.self)!
        
        let player = Player(entity: self, name: "player_blue_1", tag: "remote_player", info: rink.faceoffPositions[1])
        player.type = .PhoneRemote
        components.append(player)
        
        player.addToScene()

        player.setup()
    
        player.transitionIn(duration: 1)
    }
    
    
    
    
    
    private func startFaceoff()
    {
        components.append(Faceoff(entity: self, name: "faceoff", tag: "UI"))
    }
    
    func findFirstPlayer() -> Player?
    {
        for item in components where item is Player
        {
            if (item as! Player).index == 0
            {
                return (item as! Player)
            }
        }
        
        return nil
    }
    
}
