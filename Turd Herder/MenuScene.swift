//
//  MenuScene.swift
//  Turd Herder
//
//  Created by Brent Michalski on 8/17/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    // Grab the HUD sprite atlas
    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "HUD")
    
    // Instantiate a sprite node for the start button
    let startButton = SKSpriteNode()
    
    
//    func getDot() -> SKShapeNode {
//        let dot1 = SKShapeNode(circleOfRadius: 20)
//        dot1.fillColor = UIColor.magenta
//        dot1.zPosition = 500
//
//        return dot1
//    }
//
//    func placeDot(position: CGPoint, color: UIColor = UIColor.magenta) {
//        let dot = SKShapeNode(circleOfRadius: 20)
//        dot.fillColor = color
//        dot.zPosition = 500
//        dot.position = position
//        addChild(dot)
//    }

    
    override func didMove(to view: SKView) {
        self.name = "MenuScene"
        
        // Position the nodes from the center of the scene:
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        

        // ----------------------
        // Build the start button
        let buttonWidth  = 700
        let buttonHeight = 225
        startButton.texture = textureAtlas.textureNamed("Green_Normal").copy() as? SKTexture
        startButton.size     = CGSize(width: buttonWidth, height: buttonHeight)
        startButton.name     = "StartButton"
        startButton.position = CGPoint(x: 0, y: 0)
        self.addChild(startButton)
        
        // Add text to the button
        let startText = SKLabelNode(fontNamed: HUDSettings.font)
        startText.text                  = "Start Game"
        startText.verticalAlignmentMode = .center
        startText.fontColor             = UIColor.yellow
        startText.position              = CGPoint(x: 0, y: 2)
        startText.fontSize              = 100
        startText.name                  = "StartButton"
        startText.zPosition             = 5
        startButton.addChild(startText)

        // Pulse the start text in and out gently
        let pulseAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.5, duration: 0.9),
            SKAction.fadeAlpha(to: 1, duration: 0.9)
            ])
        startText.run(SKAction.repeatForever(pulseAction))
        // Build the start button
        // ----------------------

        
        // ----------------------
        // Main Title
        let logoText = SKLabelNode(fontNamed: HUDSettings.font)
        logoText.text      = "Turd Herder"
        logoText.fontColor = UIColor.brown
        logoText.position  = CGPoint(x: 0, y: (buttonHeight/2) + 150)
        logoText.fontSize  = 288
        logoText.name      = "logoText"
        self.addChild(logoText)
        // Main Logo
        // ----------------------
        
        
        let logoTextBottom = SKLabelNode(fontNamed: HUDSettings.font)
        logoTextBottom.text     = "Don't Make a Stink!"
        logoTextBottom.name     = "LogoTextBottom"
        logoTextBottom.fontColor = UIColor.brown
        logoTextBottom.position = CGPoint(x: 0, y: (buttonHeight/2) + 50)
        logoTextBottom.fontSize = 120
        self.addChild(logoTextBottom)
        
        scene?.run(SKAction.screenShakeWithNode(logoText, amount: CGPoint(x: 20, y: 20), oscillations: 15, duration: 3))
        scene?.run(SKAction.screenShakeWithNode(logoTextBottom, amount: CGPoint(x: 10, y: 10), oscillations: 10, duration: 3))
        
//        let shakeAction = SKAction.screenShakeWithNode(logoTextBottom, amount: CGPoint(x: 10, y: 10), oscillations: 10, duration: 1)
//        SKAction.run(shakeAction, onChildWithName: "LogoTextBottom")

        
        let tX = logoText.frame.origin.x - 150
        let tY = startButton.frame.origin.y - startButton.frame.size.height
        
        print("\n\nTx: \(tX)\nTy: \(tY)\n\n")
        
        let theToilet = ToiletNode.getToilet()
        
//        theToilet.position = CGPoint(x: tX, y: tY)
        theToilet.position = CGPoint(x: 0, y: tY)
        
        self.addChild(theToilet)
        

    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            // find the location of the touch
            let location = touch.location(in: self)
            
            // Locate the node at this location
            let nodeTouched = atPoint(location)
            
            // Check for a touch on the Start Button
            if nodeTouched.name == "StartButton" {
                
                let scene = GameScene(size: CGSize(width: 2048, height: 1536))
                scene.scaleMode = .fill
                self.view?.presentScene(scene)
            }
        }
    }
    
    
    
}


