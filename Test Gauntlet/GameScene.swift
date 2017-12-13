//
//  GameScene.swift
//  Test Gauntlet
//
//  Created by Corinne H on 2017-11-24.
//  Copyright © 2017 NFB. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        //var leftMove = SKSpriteNode(imageNamed: "leftArrow")
        //var rightMove = SKSpriteNode(imageNamed: "rightArrow")
        
        /*leftMove.position = CGPoint (x: 10, y: 20)
        rightMove.position = CGPoint (x: 15, y: 20)
        self.addChild(leftMove)
        self.addChild(rightMove)*/
        
        let title = SKLabelNode()
        title.text = "Gauntlet"
        title.fontColor = SKColor.white
        title.fontSize = 100
        title.position = CGPoint(x:15, y: self.size.height*0.075) //*0.075 for 75%
        title.zPosition = 100
        self.addChild(title)
        
        // Get label node from scene and store it for use later
        /*self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }*/
        
        var myDot = SKSpriteNode(imageNamed: "dot")
        myDot.size = CGSize (width: 150, height: 150)
        myDot.anchorPoint = CGPoint (x: 0.5, y:0.5)
        myDot.position = CGPoint (x: self.size.width*0.05, y: 10)
        myDot.name = "character"
        self.addChild(myDot)
        
        var leftArrow = SKSpriteNode(imageNamed: "leftArrow")
        leftArrow.size = CGSize (width: 180, height: 180)
        leftArrow.anchorPoint = CGPoint(x:0.5, y:0)
        leftArrow.position = CGPoint (x: self.size.width*0.025, y: -550)
        self.addChild(leftArrow)
        
        var rightArrow = SKSpriteNode(imageNamed: "rightArrow")
        rightArrow.size = CGSize (width: 180, height: 180)
        rightArrow.anchorPoint = CGPoint (x: 0.5, y: 0)
        rightArrow.position = CGPoint (x: self.size.width*0.075, y: -500)
        self.addChild(rightArrow)
        
        var moveRight = SKAction.move(by: CGVector(dx: 200, dy: 0), duration: 1)
        var moveUp = SKAction.move(by: CGVector(dx: 0, dy: 200), duration: 1)
        //var movingBackAndForth = SKAction.sequence([moveRight, moveRight.reversed()])
        
        var mySequence = SKAction.sequence([moveRight, moveUp, moveRight.reversed(), moveUp.reversed()])
        
         func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in (touches) {
                let positionInScene = touch.location(in: self)
                let touchedNode = self.atPoint(positionInScene)
                if let name = touchedNode.name {
                    if name == "leftArrow" {
                        myDot.run(moveRight.reversed())
                    }
                    if name == "rightArrow" {
                        myDot.run(moveRight)
                    }
                }
            }
        }
        
        
        
        // Create shape node to use during mouse interaction
        /*let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            //spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              /*SKAction.fadeOut(withDuration: 0.5),*/
                                              SKAction.removeFromParent()]))
        }*/
    }
    
    
    
    
    /*func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            //n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            //n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            //n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    */
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
