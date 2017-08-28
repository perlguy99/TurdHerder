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
    
    var theToilet: SKSpriteNode!
    
    
    // Instantiate a sprite node for the start button
    let startButton = SKSpriteNode()
    
//    var oldAnchorPoint:CGPoint!
    
    override func didMove(to view: SKView) {
        
        self.name = "MenuScene"
        
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
        
        
        theToilet = loadToilet("Toilet")
        
        
//        print("---")
//        print(theToilet?.isHidden)
//        print(theToilet?.position)
//        print(self.children)
//        print("---")
        
//        theToilet.removeFromParent()
        
//        let toiletScene = SKScene(fileNamed: "Toilet")!
//        let theToilet = toiletScene.childNode(withName: "toilet_body") as! SKSpriteNode
        
        
        let newToilet = self.theToilet.copy() as! SKSpriteNode
        
        newToilet.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        newToilet.position = CGPoint(x: 100, y: 100)
        newToilet.zPosition = 2

//        print("+++")
//        print(theToilet.parent)
//        print("+++")

        
        
        self.addChild(newToilet)

//        print("***")
//        print(theToilet.parent)
//        print("***")
        
    }
    
    
    func loadToilet(_ fileName: String) -> SKSpriteNode {
        let toiletScene = SKScene(fileNamed: fileName)!
        toiletScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
//        let toiletTemplate = toiletScene.childNode(withName: "//toilet_body")
//        let toiletTemplate = toiletScene.childNode(withName: "*")
        let toiletTemplate = toiletScene.childNode(withName: "toilet_body")
        
//        print("---")
//        print(toiletTemplate?.children)
//        print(toiletTemplate?.parent)
//        print("---")
        
//        let toiletTemplate = toiletScene.childNode(withName: "//MyToilet")
        
        toiletTemplate?.position = CGPoint(x: 150, y: 150)
        toiletTemplate?.zPosition = 2
        
//        toiletScene.position = CGPoint(x: 150, y: 150)
//        toiletScene.zPosition = 4
//
//        toiletScene.removeFromParent()
//
//        self.addChild(toiletScene)
        
//        print("---")
//        print(toiletTemplate?.isHidden)
//        print(toiletTemplate?.position)
//        print(self.children)
//        print("---")
        
//        toiletTemplate?.removeFromParent()
        
        return toiletTemplate as! SKSpriteNode
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


