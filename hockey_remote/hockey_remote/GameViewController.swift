//
//  GameViewController.swift
//  hockey_remote
//
//  Created by Ty Wood on 12/13/16.
//  Copyright © 2016 tyskwo. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit



// network handler - singleton
var networkHandler: NetworkHandler!



class GameViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let view = self.view as! SKView?
        {
            // load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene")
            {
                // set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // create network handler and start looking for server
                networkHandler = NetworkHandler()
                networkHandler.startBrowsing()
                
                // present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool
    {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        return .landscapeLeft
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}
