//
//  GameScene.swift
//  Test Gauntlet
//
//  Created by Corinne H on 2017-11-24.
//  Copyright © 2017 NFB. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit

var pause = Timer()

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Label Variables
    let title = SKLabelNode()
    var score = SKLabelNode()
    var scoreValue = 0
    
    // Sprite Node Variables
    var player =  SKSpriteNode()
    var ghost = SKSpriteNode()
    var exit = SKSpriteNode()
    var food = SKSpriteNode()
    var treasure = SKSpriteNode()
    var key = SKSpriteNode()
    
    var leftArrow = SKSpriteNode()
    var rightArrow = SKSpriteNode()
    var upArrow = SKSpriteNode()
    var downArrow = SKSpriteNode()
    var fireButton = SKSpriteNode()
    var arrow = SKSpriteNode()
    var arrowNode = SKSpriteNode()
    
    
    // Directional Variables
    var orientation = CGFloat(Double.pi/2)
    var directionx = CGFloat(0)
    var directiony = CGFloat(1)
    var contactQueue = [SKPhysicsContact]()
    
    // Bit Masks
    let playerCategory: UInt32 = 0x1 << 0
    let arrowCategory: UInt32 = 0x1 << 1
    let enemyCategory: UInt32 = 0x1 << 2
    let itemCategory: UInt32 = 0x1 << 3
    let usedItemCategory: UInt32 = 0x1 << 4
    
    
    // Overridden Functions
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        
        //Title - "Gauntlet"
        title.text = "Gauntlet"
        title.fontColor = SKColor.white
        title.fontSize = 60
        title.position = CGPoint(x:220, y: -350)
        title.zPosition = 100
        self.addChild(title)
        
        //Score
        score.text = "Score: \(scoreValue)"
        score.fontColor = SKColor.white
        score.fontName = "Futura"
        score.fontSize = 60
        score.position = CGPoint(x:220, y: -400)
        score.zPosition = 100
        self.addChild(score)
        
        //Player - Elf
        player = createSN(image: "Elf", name: "character", position: CGPoint(x:-330, y:-260), isDynamic: true)
        
        
        /*player = SKSpriteNode(imageNamed: "Elf Sprite (U)")
        player.name = "character"
        player.size = CGSize (width: 50, height: 50)
        player.anchorPoint = CGPoint (x: 0.5, y:0.5)
        player.position = CGPoint (x: -330, y: -260)
        player.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Elf Sprite (U)"), size: player.size)
        if let physics = player.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = true
            physics.linearDamping = 1
            physics.angularDamping = 1
        }*/
        player.physicsBody?.usesPreciseCollisionDetection = true
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.collisionBitMask = itemCategory
        player.physicsBody?.contactTestBitMask = itemCategory
        self.addChild(player)
        
        //Monster - Ghost
        ghost = createSN (image: "Ghost", name: "ghost", position: CGPoint(x: 330, y: -90), isDynamic: false)
        
        ghost.physicsBody?.restitution = 0
        /*ghost = SKSpriteNode(imageNamed: "Ghost Sprite (U)")
        ghost.name = "ghost"
        ghost.size = CGSize (width: 50, height: 50)
        ghost.anchorPoint = CGPoint (x: 0.5, y:0.5)
        //ghost.position = CGPoint (x: 330, y: -90)
        ghost.position = CGPoint (x: -110, y: -100)  //test (close to start)
        ghost.physicsBody = SKPhysicsBody(rectangleOf: ghost.frame.size)
        if let physics = ghost.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = false
            physics.linearDamping = 1
            physics.angularDamping = 1
            physics.restitution = 0
        }*/
        ghost.physicsBody?.usesPreciseCollisionDetection = true
        ghost.physicsBody?.categoryBitMask = enemyCategory
        ghost.physicsBody?.collisionBitMask = arrowCategory
        ghost.physicsBody?.contactTestBitMask = arrowCategory
        self.addChild(ghost)
        
        //Exit
        exit = createSN (image: "Exit", name: "exit", position: CGPoint(x: 330, y: -245), isDynamic: false)
        /*exit = SKSpriteNode(imageNamed: "Exit")
        exit.name = "end"
        exit.size = CGSize (width: 50, height: 50)
        exit.anchorPoint = CGPoint(x:0.5, y:0.5)
        exit.position = CGPoint (x: 330, y: -245)  //actual position
        //exit.position = CGPoint (x: -330, y: 0)  //test (close to start)
        exit.zPosition = -1
        exit.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "exit"), size: exit.size)
        if let physics = exit.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = false
            physics.linearDamping = 1
            physics.angularDamping = 1
        }*/
        exit.physicsBody?.usesPreciseCollisionDetection = true
        exit.physicsBody?.categoryBitMask = itemCategory
        self.addChild(exit)
 
        //Food#1
        food = createSN (image: "Food1", name: "food", position: CGPoint(x: -125, y: 0), isDynamic: false)
        /*food = SKSpriteNode(imageNamed: "Food #1")
        food.name = "food1"
        food.size = CGSize (width: 50, height: 50)
        food.anchorPoint = CGPoint(x:0.5, y:0.5)
        food.position = CGPoint (x: -125, y: 0)  //actual position
        food.zPosition = -1
        food.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Food #1"), size: food.size)
        if let physics = food.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = false
            physics.linearDamping = 1
            physics.angularDamping = 1
        }*/
        food.physicsBody?.usesPreciseCollisionDetection = true
        food.physicsBody?.categoryBitMask = itemCategory
        self.addChild(food)
        
        //Treasure
        treasure = createSN (image: "Treasure", name: "treasure", position: CGPoint(x: 320, y: 430), isDynamic: false)
        /*treasure = SKSpriteNode(imageNamed: "Treasure Sprite")
        treasure.name = "Treasure"
        treasure.size = CGSize (width: 50, height: 50)
        treasure.anchorPoint = CGPoint(x:0.5, y:0.5)
        treasure.position = CGPoint (x: 320, y: 430)
        treasure.zPosition = -1
        treasure.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Treasure Sprite"), size: food.size)
        if let physics = treasure.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = false
            physics.linearDamping = 1
            physics.angularDamping = 1
        }*/
        treasure.physicsBody?.usesPreciseCollisionDetection = true
        treasure.physicsBody?.categoryBitMask = itemCategory
        self.addChild(treasure)
        
        key = createSN (image: "Key", name: "key", position: CGPoint(x: -320, y: 430), isDynamic: false)
        /*key = SKSpriteNode(imageNamed: "Key Sprite")
        key.name = "Key"
        key.size = CGSize (width: 50, height: 50)
        key.anchorPoint = CGPoint(x:0.5, y:0.5)
        key.position = CGPoint (x: -320, y: 430)
        key.zPosition = -1
        key.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "Key Sprite"), size: key.size)
        if let physics = key.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = false
            physics.linearDamping = 1
            physics.angularDamping = 1
        }*/
        key.physicsBody?.usesPreciseCollisionDetection = true
        key.physicsBody?.categoryBitMask = itemCategory
        self.addChild(key)
        
        //Left control arrow
        leftArrow = SKSpriteNode(imageNamed: "LeftArrow")
        leftArrow.name = "leftControlArrow"
        leftArrow.size = CGSize (width: 100, height: 100)
        leftArrow.anchorPoint = CGPoint(x:0.5, y:0)
        leftArrow.position = CGPoint (x: -320, y: -440)
        self.addChild(leftArrow)
        
        //Right control arrow
        rightArrow = SKSpriteNode(imageNamed: "RightArrow")
        rightArrow.name = "rightControlArrow"
        rightArrow.size = CGSize (width: 100, height: 100)
        rightArrow.anchorPoint = CGPoint (x: 0.5, y: 0)
        rightArrow.position = CGPoint (x: -120, y: -440)
        self.addChild(rightArrow)
        
        //Up control arrow
        upArrow = SKSpriteNode(imageNamed: "UpArrow")
        upArrow.name = "upControlArrow"
        upArrow.size = CGSize (width: 100, height: 100)
        upArrow.anchorPoint = CGPoint (x: 0.5, y: 0)
        upArrow.position = CGPoint (x: -220, y: -380)
        self.addChild(upArrow)
        
        //Down control arrow
        downArrow = SKSpriteNode(imageNamed: "DownArrow")
        downArrow.name = "downControlArrow"
        downArrow.size = CGSize (width: 100, height: 100)
        downArrow.anchorPoint = CGPoint (x: 0.5, y: 0)
        downArrow.position = CGPoint (x: -220, y: -500)
        self.addChild(downArrow)
        
        //Fire button
        fireButton = SKSpriteNode(imageNamed: "Exit")
        fireButton.name = "fireControl"
        fireButton.size = CGSize (width: 100, height: 100)
        fireButton.anchorPoint = CGPoint (x: 0.5, y: 0)
        fireButton.position = CGPoint (x: 0, y: -440)
        self.addChild(fireButton)
        
    }
    
    
    
    //arrow move control
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let moveRight = SKAction.move(by: CGVector(dx: 50, dy: 0), duration: 0.2)
        let moveUp = SKAction.move(by: CGVector(dx: 0, dy: 50), duration: 0.2)
        for touch in (touches) {
            let positionInScene = touch.location(in: self)
            if rightArrow.contains(positionInScene) {
                player.run(moveRight)
                if player.zRotation != CGFloat(-Double.pi/2) {
                    player.zRotation = CGFloat(-Double.pi/2)
                    orientation = CGFloat(0)
                    directionx = 1
                    directiony = 0
                }
            }
            if leftArrow.contains(positionInScene) {
                player.run(moveRight.reversed()) //moveLeft
                if player.zRotation != CGFloat(Double.pi/2) {
                    player.zRotation = CGFloat(Double.pi/2)
                    orientation = CGFloat(Double.pi)
                    directionx = -1
                    directiony = 0
                }
            }
            if upArrow.contains(positionInScene) {
                player.run(moveUp)
                if player.zRotation != CGFloat(0) {
                    player.zRotation = CGFloat(0)
                    orientation = CGFloat(Double.pi/2)
                    directionx = 0
                    directiony = 1
                }
            }
            if downArrow.contains(positionInScene) {
                player.run(moveUp.reversed()) //moveDown
                if player.zRotation != CGFloat(Double.pi) {
                    player.zRotation = CGFloat(Double.pi)
                    orientation = CGFloat(-Double.pi/2)
                    directionx = 0
                    directiony = -1
                }
            }
            if fireButton.contains(positionInScene){
                if let archerNode = self.childNode(withName: "character"){
                    print ("Shoot")
                    let shootArrow = SKAction.run({
                        self.arrowNode = self.createArrowNode()
                        self.addChild(self.arrowNode)
                        self.arrowNode.physicsBody?.applyImpulse(CGVector(dx: self.directionx * 30, dy: self.directiony * 30))
                    })
                    archerNode.run(shootArrow)
                }
            }
        }
    }
    
    //complete level - Currently Message "You Win!!!"
    func didBegin(_ contact: SKPhysicsContact){
        contactQueue.append(contact)
        let firstNode = contact.bodyA.node as! SKSpriteNode
        let secondNode = contact.bodyB.node as! SKSpriteNode
        
        if (contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == itemCategory){
            print("check")
            
            //scoreValue = scoreValue + 1
            
            if secondNode == exit {
                player.removeFromParent()
                exit.physicsBody?.categoryBitMask = usedItemCategory
                gameTimer.invalidate()
                scoreValue += seconds
                print(seconds)
                score.text = "Score: \(scoreValue)"
                //let newScene = self.storyboard?.instantiateViewController(withIdentifier: "scoreVC") as! scoreViewController
                //self.present(newScene, animated: true, completion: nil)
                //pause = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(GameViewController.end), userInfo: nil, repeats: false)
            }
            
            if secondNode == food {
                scoreValue = scoreValue + 15
                food.removeFromParent()
                food.physicsBody?.categoryBitMask = usedItemCategory
            }
            if secondNode == treasure {
                scoreValue = scoreValue + 150
                treasure.removeFromParent()
                treasure.physicsBody?.categoryBitMask = usedItemCategory
            }
            if secondNode == key {
                scoreValue = scoreValue + 100
                key.removeFromParent()
                key.physicsBody?.categoryBitMask = usedItemCategory
            }
            print (scoreValue)
            score.text = "Score: \(scoreValue)"
            
        }else if (contact.bodyA.categoryBitMask == arrowCategory) && (contact.bodyB.categoryBitMask == enemyCategory){
            print("HIT")
            ghost.removeFromParent()
            arrow.removeFromParent()
        }
    }
    
    /*func didEnd(_ contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == playerCategory) && (contact.bodyB.categoryBitMask == itemCategory){
            //scoreValue = scoreValue + 1
            //print (scoreValue)
            //score.text = "Score: \(scoreValue)"
            
        }
    }*/

    func createArrowNode() -> SKSpriteNode {
        let archerNode = self.childNode(withName: "character")
        let archerPosition = archerNode?.position
        let archerWidth = archerNode?.frame.size.width
        let archerHeight = archerNode?.frame.size.height

        arrow = SKSpriteNode(imageNamed: "Arrow")
        
        arrow.position = CGPoint(x: archerPosition!.x + directionx * archerWidth!, y: archerPosition!.y + directiony*archerHeight!)
        arrow.size = CGSize(width: 40, height: 30)
        arrow.zRotation = CGFloat(orientation)
        
        arrow.name = "arrowNode"
        arrow.physicsBody = SKPhysicsBody(rectangleOf: arrow.frame.size)
        
        if let physics = arrow.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = true
            physics.linearDamping = 1
            physics.angularDamping = 1
            physics.restitution = 0
        }
        arrow.physicsBody?.usesPreciseCollisionDetection = true
        arrow.physicsBody?.categoryBitMask = arrowCategory
        arrow.physicsBody?.collisionBitMask = enemyCategory
        arrow.physicsBody?.contactTestBitMask = enemyCategory
        return arrow
    }
    
    func createSN(image: String, name: String, position: CGPoint, isDynamic: Bool) -> SKSpriteNode {
        var node = SKSpriteNode(imageNamed: image)
        node.name = name
        node.size = CGSize (width: 50, height: 50) //Always the same
        node.anchorPoint = CGPoint (x: 0.5, y:0.5) //Always the same
        node.position = position
        node.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: image), size: node.size)
        if isDynamic {
        if let physics = node.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = false
            physics.isDynamic = true
            physics.linearDamping = 1
            physics.angularDamping = 1
            }
            
        }
        else {
            if let physics = node.physicsBody {
                physics.affectedByGravity = false
                physics.allowsRotation = false
                physics.isDynamic = false
                physics.linearDamping = 1
                physics.angularDamping = 1
            }
        }
        return node
    }
    
    
}

