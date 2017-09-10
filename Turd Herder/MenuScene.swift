//
//  MenuScene.swift
//  Turd Herder
//
//  Created by Brent Michalski on 8/17/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    let shortFarts = [
        SKAction.playSoundFileNamed("fart2.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart3.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart4.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart6.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart7.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart8.mp3", waitForCompletion: false),
        ]
    
    // Grab the HUD sprite atlas
    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "HUD")
    
    // Instantiate a sprite node for the start button
    let startButton = SKSpriteNode()
    
    
    func getDot() -> SKShapeNode {
        let dot1 = SKShapeNode(circleOfRadius: 20)
        dot1.fillColor = UIColor.magenta
        dot1.zPosition = 500

        return dot1
    }

    func placeDot(position: CGPoint, color: UIColor = UIColor.magenta) {
        let dot = SKShapeNode(circleOfRadius: 20)
        dot.fillColor = color
        dot.zPosition = 1500
        dot.position = position
        addChild(dot)
    }

    
    
    override func didMove(to view: SKView) {
        self.name = "MenuScene"
        
//        let sHeight = self.view?.frame.height
//        let sWidth  = self.view?.frame.width
//
//        print("\n\n+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+")
//        print("Width: \(sWidth)\nHeight: \(sHeight)")
//        print(self.scene?.size)
//        print("+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\n\n")
        
        
//        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
//        placeDot(position: CGPoint(x: 0, y: 0), color: UIColor.purple)
        
        let topY = sceneHeight/2.0
        let topX = sceneWidth/2.0
//        placeDot(position: CGPoint(x: 0, y: topY) , color: UIColor.green)
//        placeDot(position: CGPoint(x: 0, y: -topY) , color: UIColor.blue)
//        placeDot(position: CGPoint(x: -topX, y: 0) , color: UIColor.yellow)
//        placeDot(position: CGPoint(x: topX, y: 0) , color: UIColor.magenta)
        
        
        // Position the nodes from the center of the scene:
//        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        

        // ----------------------
        // Build the start button
//        let buttonWidth  = 700
        let buttonHeight = 225
        
        let startGameButton   = SKSpriteNode(imageNamed: "start_game")
        startGameButton.zPosition = 1000
        startGameButton.position = .zero
        startGameButton.name = "startGameButton"
        startGameButton.setScale(0)
        self.addChild(startGameButton)
        
//        startButton.texture = textureAtlas.textureNamed("Green_Normal").copy() as? SKTexture
//        startButton.size     = CGSize(width: buttonWidth, height: buttonHeight)
//        startButton.name     = "StartButton"
//        startButton.position = CGPoint(x: 0, y: 0)
////        self.addChild(startButton)
//
//        // Add text to the button
//        let startText = SKLabelNode(fontNamed: HUDSettings.font)
//        startText.text                  = "Start Game"
//        startText.verticalAlignmentMode = .center
//        startText.fontColor             = UIColor.yellow
//        startText.position              = CGPoint(x: 0, y: 2)
//        startText.fontSize              = 100
//        startText.name                  = "StartButton"
//        startText.zPosition             = 5
//        startButton.addChild(startText)

        // Pulse the start text in and out gently
        let pulseAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.6, duration: 0.5),
            SKAction.fadeAlpha(to: 1, duration: 0.9)
            ])
        startGameButton.run(SKAction.repeatForever(pulseAction))
        // Build the start button
        // ----------------------

        
        // ----------------------
        // Main Title
        let turd_logo   = SKSpriteNode(imageNamed: "turd_logo")
        let herder_logo = SKSpriteNode(imageNamed: "herder_logo")
        let stink_logo  = SKSpriteNode(imageNamed: "dont_make_a_stink")
        
        turd_logo.setScale(0)
        turd_logo.zPosition = 1000
        turd_logo.name = "turd_logo"
        
        herder_logo.setScale(0)
        herder_logo.zPosition = 1000
        herder_logo.name = "herder_logo"
        
        stink_logo.setScale(0)
        stink_logo.zPosition = 1000
        stink_logo.name = "stink_logo"
        
        let titleXt = CGFloat(-400.0)
        let titleYt = CGFloat((buttonHeight/2) + 350)
        let titleXh = CGFloat(400.0)
        let titleYh = CGFloat((buttonHeight/2) + 350)

        let titleXs = CGFloat(0)
        let titleYs = CGFloat((buttonHeight/2) + 125)
        
        turd_logo.position   = CGPoint(x: titleXt, y: titleYt)
        herder_logo.position = CGPoint(x: titleXh, y: titleYh)
        stink_logo.position  = CGPoint(x: titleXs, y: titleYs)
        
        self.addChild(turd_logo)
        self.addChild(herder_logo)
        self.addChild(stink_logo)
        
        let scaleUp          = SKAction.scale(to: 2.5, duration: 1.0)
        let scaleDown        = SKAction.scale(to: 2.0, duration: 0.25)
        let scaleDownS       = SKAction.scale(to: 1.8, duration: 0.25)

        scaleDown.timingMode = .easeInEaseOut
        scaleUp.timingMode   = .easeInEaseOut
        
        let shakeT = SKAction.screenShakeWithNode(turd_logo, amount: CGPoint(x: 20, y: 20), oscillations: 15, duration: 2)
        let shakeH = SKAction.screenShakeWithNode(herder_logo, amount: CGPoint(x: 20, y: 20), oscillations: 15, duration: 2)
        let shakeS = SKAction.screenShakeWithNode(stink_logo, amount: CGPoint(x: 20, y: 20), oscillations: 15, duration: 2)
        
        let sequenceT = SKAction.sequence([scaleUp, scaleDown, shakeT])
        let sequenceH = SKAction.sequence([scaleUp, scaleDown, shakeH])
        
        let randomFart = Int.random(shortFarts.count)

        let sequenceS = SKAction.sequence([scaleUp, scaleDownS, shortFarts[randomFart], shakeS])
        
        turd_logo.run(sequenceT)
        herder_logo.run(sequenceH)
        stink_logo.run(SKAction.afterDelay(2.0, performAction: sequenceS))
        
        
        // Now, scale the start button into position
        let scaleStartUp   = SKAction.scale(to: 1.50, duration: 1.0)
        let scaleStartDown = SKAction.scale(to: 1.25, duration: 0.5)
        
        startGameButton.run(SKAction.afterDelay(3.0, performAction: SKAction.sequence([scaleStartUp, scaleStartDown])))
        
        
//        let tX = logoText.frame.origin.x - 150
//        let tY = startButton.frame.origin.y - startButton.frame.size.height
        
        let theToilet = ToiletNode.getToilet()
        
//        theToilet.position = CGPoint(x: tX, y: tY)
        theToilet.position = CGPoint(x: 0, y: -350)
        
        self.addChild(theToilet)
        

    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            // find the location of the touch
            let location = touch.location(in: self)
            
            // Locate the node at this location
            let nodeTouched = atPoint(location)
            
            // Check for a touch on the Start Button
            if nodeTouched.name == "startGameButton" {
                
                let scene = GameScene(size: CGSize(width: 2048, height: 1536))
                scene.scaleMode = .fill
                self.view?.presentScene(scene)
            }
        }
    }
    
    
    
}


