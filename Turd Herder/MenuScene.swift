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
    
//    var oldAnchorPoint:CGPoint!
    
    override func didMove(to view: SKView) {
        // Position the nodes from the center of the scene:
//        oldAnchorPoint = self.anchorPoint
        
//        print(oldAnchorPoint.debugDescription)
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // Add any background images, set zPosition to -1
        
        let logoText = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        logoText.text     = "Turd Herder"
        logoText.position = CGPoint(x: 0, y: 100)
        logoText.fontSize = 60
        self.addChild(logoText)

        let logoTextBottom = SKLabelNode(fontNamed: "AvenirNext-Heavy")
        logoTextBottom.text     = "Don't Make a Stink!"
        logoTextBottom.position = CGPoint(x: 0, y: 50)
        logoTextBottom.fontSize = 40
        self.addChild(logoTextBottom)

        // ----------------------
        // Build the start button
        startButton.texture = textureAtlas.textureNamed("button")
        startButton.size = CGSize(width: 295, height: 76)
        
        // Name the start node for touch detection
        startButton.name  = "StartButton"
        startButton.position = CGPoint(x: 0, y: -20)
        self.addChild(startButton)
        
        // Add text to the button
        let startText = SKLabelNode(fontNamed: "AvenirNext-HeavyItalic")
        startText.text = "START GAME"
        startText.verticalAlignmentMode = .center
        startText.position = CGPoint(x: 0, y: 2)
        startText.fontSize = 40
        
        // Name the text node for touch detection
        startText.name = "StartButton"
        startText.zPosition = 5
        startButton.addChild(startText)

        // Pulse the start text in and out gently
        let pulseAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.5, duration: 0.9),
            SKAction.fadeAlpha(to: 1, duration: 0.9)
            ])
        startText.run(SKAction.repeatForever(pulseAction))
        // ----------------------
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            // find the location of the touch
            let location = touch.location(in: self)
            
            // Locate the node at this location
            let nodeTouched = atPoint(location)
            
            if nodeTouched.name == "StartButton" {
                if let scene = SKScene(fileNamed: "Scene") {
                    self.view?.presentScene(scene)
                }
            }
        }
    }
    
    
    
}


