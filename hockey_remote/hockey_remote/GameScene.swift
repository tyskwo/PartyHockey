//
//  GameScene.swift
//  hockey_remote
//
//  Created by Ty Wood on 12/13/16.
//  Copyright © 2016 tyskwo. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    override func didMove(to view: SKView) {}
    
    
    func touchDown(atPoint pos : CGPoint)
    {
        let touchedNode = self.atPoint(pos)
        
        if let name = touchedNode.name
        {
            if name == "button"
            {
                let buttonPacket = ButtonPacket(isPressEnd: false)
                let packet = Packet(objectType: ObjectType.ButtonPacket, object: buttonPacket)
                networkHandler.send(packet: packet)
                print("Button packet sent")
            }
        }
            
        else
        {
            let p = CGPoint(x: (pos.x / size.height * 0.8), y: (pos.y / size.height) * 1.75)
            let touchPacket = TouchPacket(position_x: p.x, position_y: p.y, isTouchEnd: false)
            let packet = Packet(objectType: ObjectType.TouchPacket, object: touchPacket)
            networkHandler.send(packet: packet)
            print("Touch packet sent")
        }

    }
    
    func touchUp(atPoint pos : CGPoint)
    {
        let touchedNode = self.atPoint(pos)
        
        if let name = touchedNode.name
        {
            if name == "button"
            {
                let buttonPacket = ButtonPacket(isPressEnd: true)
                let packet = Packet(objectType: ObjectType.ButtonPacket, object: buttonPacket)
                networkHandler.send(packet: packet)
                print("Button packet sent")
            }
        }
        else
        {
            let p = CGPoint(x: (pos.x / size.height * 0.8), y: (pos.y / size.height) * 1.75)
            let touchPacket = TouchPacket(position_x: p.x, position_y: p.y, isTouchEnd: true)
            let packet = Packet(objectType: ObjectType.TouchPacket, object: touchPacket)
            networkHandler.send(packet: packet)
            print("Touch packet sent")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
}
