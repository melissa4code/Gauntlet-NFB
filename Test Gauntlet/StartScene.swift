//
//  StartScene.swift
//  Test Gauntlet
//
//  Created by Melissa Chinnick on 2017-12-14.
//  Copyright © 2017 NFB. All rights reserved.
//

import UIKit
import GameplayKit

class StartScene: SKScene {
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let startNode = childNode(withName: "startButton")
        if (startNode != nil) {
            let fadeAway = SKAction.fadeOut(withDuration: 1.0)

            startNode?.run(fadeAway, completion: {
                let doors = SKTransition.doorway(withDuration: 1.0)
                let gameScene = GameScene(fileNamed: "GameScene")
                self.view?.presentScene(gameScene!, transition: doors)
            })
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
