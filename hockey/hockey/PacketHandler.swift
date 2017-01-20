import Foundation


public class PacketHandler
{
    static var connectedRemotes: [String] = []
    
    static func Receive(packet: Packet)
    {
        switch packet.objectType!
        {
        case .TouchPacket:
            let touchPacket = packet.getObject() as TouchPacket
            
            if(touchPacket.isTouchEnd!)
            {
                (scene as! GameScene).currentScreen.findAllOf(component: Player.self)[1].movementControls.touchEnd = CGPoint(x: touchPacket.position.x, y: touchPacket.position.y)
            }
            else
            {
                (scene as! GameScene).currentScreen.findAllOf(component: Player.self)[1].movementControls.touchBegin = CGPoint(x: touchPacket.position.x, y: touchPacket.position.y)
            }

            print("Touch received, at: \(touchPacket.position)   state: \(touchPacket.isTouchEnd)")
            break
            
            
        case .ButtonPacket:
            let buttonPacket = packet.getObject() as ButtonPacket
            
            if(buttonPacket.isPressEnd!)
            {
                (scene as! GameScene).currentScreen.findAllOf(component: Player.self)[1].movementControls.pressedA(false)
            }
            else
            {
                (scene as! GameScene).currentScreen.findAllOf(component: Player.self)[1].movementControls.pressedA(true)
            }

            
            print("Button press received: state: \(buttonPacket.isPressEnd)")
            /*for p in (scene as! GameScene).currentScreen.findAllOf(component: Player.self)
            {
                if(p.index == 2)
                {
                    p.movementControls.receiveButtonState(buttonPacket.isPressEnd)
                }
            }*/
            break
            
        case .NamePacket:
            let namePacket = packet.getObject() as NamePacket
            
            if !connectedRemotes.contains(namePacket.name)
            {
                connectedRemotes.append(namePacket.name)
            }

            break
        }
    }
    
}
