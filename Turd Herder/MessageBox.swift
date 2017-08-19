//
//  MessageBox.swift
//  Turd Herder
//
//  Created by Brent Michalski on 8/18/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import SpriteKit

class MessageBox: SKNode {
    
    var toiletNode: ToiletNode!
    
    
    
//    var toiletNode = ToiletNode().childNode(withName: "//toilet_body")!
    
    
    
//    let toiletNode = SKSpriteNode(fileNamed: "Toilet")!.childNode(withName: "toilet_body")!
//    let toiletNode = SKSpriteNode(fileNamed: "Toilet")!
    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "HUD")
    
    
    func createMessageBox(size: CGSize, message: String) {
        
        // Add any background images, set zPosition to -1
        let background = SKSpriteNode()
        background.texture = textureAtlas.textureNamed("button")
        background.name = "background"
        background.size = size
        background.zPosition = -1
        background.position = .zero
        self.addChild(background)
        
        background.addChild(toiletNode)
        
        
        
//        let logoText = SKLabelNode(fontNamed: "AvenirNext-Heavy")
//        logoText.text     = "Turd Herder"
//        logoText.position = CGPoint(x: 0, y: 100)
//        logoText.fontSize = 60
//        self.addChild(logoText)
//
//        let logoTextBottom = SKLabelNode(fontNamed: "AvenirNext-Heavy")
//        logoTextBottom.text     = "Don't Make a Stink!"
//        logoTextBottom.position = CGPoint(x: 0, y: 50)
//        logoTextBottom.fontSize = 40
//        self.addChild(logoTextBottom)
        
        // ----------------------
        // Build the start button
//        startButton.texture = textureAtlas.textureNamed("button")
//        startButton.size = CGSize(width: 295, height: 76)
//
//        // Name the start node for touch detection
//        startButton.name  = "StartButton"
//        startButton.position = CGPoint(x: 0, y: -20)
//        self.addChild(startButton)
//
//        // Add text to the button
//        let startText = SKLabelNode(fontNamed: "AvenirNext-HeavyItalic")
//        startText.text = "START GAME"
//        startText.verticalAlignmentMode = .center
//        startText.position = CGPoint(x: 0, y: 2)
//        startText.fontSize = 40
//
//        // Name the text node for touch detection
//        startText.name = "StartButton"
//        startText.zPosition = 5
//        startButton.addChild(startText)
//
//        // Pulse the start text in and out gently
//        let pulseAction = SKAction.sequence([
//            SKAction.fadeAlpha(to: 0.5, duration: 0.9),
//            SKAction.fadeAlpha(to: 1, duration: 0.9)
//            ])
//        startText.run(SKAction.repeatForever(pulseAction))
        // ----------------------
        
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in (touches) {
//            // find the location of the touch
//            let location = touch.location(in: self)
//
//            // Locate the node at this location
//            let nodeTouched = atPoint(location)
//
//            if nodeTouched.name == "StartButton" {
//                if let scene = SKScene(fileNamed: "Scene") {
//                    self.view?.presentScene(scene)
//                }
//            }
//        }
//    }
//
    
    
}


