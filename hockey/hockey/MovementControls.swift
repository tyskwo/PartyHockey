import SpriteKit
import GameController


class MovementControls
{
    static var canMove:Bool! = false
    var player: Player!
    
    var isAPressed = false
    
    var touchBegin: CGPoint?, touchEnd: CGPoint?

    
    func set(player: Player)
    {
        self.player = player
    }
    
    func update()
    {
        if MovementControls.canMove!
        {
            if let deltas = getDelta()
            {
                if isAPressed && player.puck != nil
                {
                    player.shoot(with: deltas)
                    isAPressed = false
                }
                else
                {
                    player.node.physicsBody!.velocity = CGVector(dx: -deltas.x, dy: deltas.y)
                }
                
                touchReceived()
            }
            
            
            if isAPressed && player.puck == nil
            {
                let puck = player.entity.find(component: Puck.self)!
                
                let distance = (player.node.position.x - puck.node.position.x) * (player.node.position.x - puck.node.position.x) +
                               (player.node.position.y - puck.node.position.y) * (player.node.position.y - puck.node.position.y)
                if distance < pow(110, 2)
                {
                    player.addPuck(puck)
                }
                
                let players = player.entity.findAllOf(component: Player.self)
                
                for p in players
                {
                    if p !== player
                    {
                        if player.node.intersects(p.node) && p.puck != nil
                        {
                            p.losePuck(checkerPosition: player.node.position, checkerVelocity: player.node.physicsBody!.velocity)
                        }

                    }
                }
            }
        }
    }
    
    func getDelta() -> (x: CGFloat, y: CGFloat)?
    {
        let multiplier:CGFloat = 1000
        
        if touchBegin != nil && touchEnd != nil
        {
            let deltaX = (touchEnd!.x - touchBegin!.x) * multiplier //* (1920/1080)
            let deltaY = (touchEnd!.y - touchBegin!.y) * multiplier
            
            if player.type == .SiriRemote  { return (deltaY, deltaX) }
            else
            {
                return (-deltaX, deltaY)
            }
        }
        
        return nil
    }
    
    func touchReceived()
    {
        touchBegin = nil
        touchEnd   = nil
    }
    
    func pressedA(_ started: Bool)
    {
        isAPressed = started
        
        if isAPressed
        {
            player.halo.alpha = 1

            if(player.getName().contains("red"))
            {
                player.node.texture = SKTexture(imageNamed: "red_player_action")
            }
            else
            {
                player.node.texture = SKTexture(imageNamed: "blue_player_action")
            }
        }
        else
        {
            player.halo.alpha = 0
            
            if(player.getName().contains("red"))
            {
                player.node.texture = SKTexture(imageNamed: "red_player")
            }
            else
            {
                player.node.texture = SKTexture(imageNamed: "blue_player")
            }
        }
    }
}
