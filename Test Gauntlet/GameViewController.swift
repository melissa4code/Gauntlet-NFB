//
//  GameViewController.swift
//  Test Gauntlet
//
//  Created by Corinne H on 2017-11-24.
//  Copyright © 2017 NFB. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Foundation
var gameTimer = Timer()
var seconds = 100

class GameViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.counter), userInfo: nil, repeats: true)
        
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    @objc func counter() {
        seconds -= 1
        
        if seconds <= 0 {
            gameTimer.invalidate()
        }
        
        timerLabel.text = ("Time: \(seconds)")
    }
}

