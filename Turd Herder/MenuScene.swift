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
    
    
    func getDot() -> SKShapeNode {
        let dot1 = SKShapeNode(circleOfRadius: 20)
        dot1.fillColor = UIColor.magenta
        dot1.zPosition = 500
        
        return dot1
    }
    
    func placeDot(position: CGPoint, color: UIColor = UIColor.magenta) {
        let dot = SKShapeNode(circleOfRadius: 20)
        dot.fillColor = color
        dot.zPosition = 500
        dot.position = position
        addChild(dot)
    }
    
    override func didMove(to view: SKView) {
        
        self.name = "MenuScene"
        
        // Position the nodes from the center of the scene:
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)

//        placeDot(position: CGPoint(x: 0, y: 0), color: UIColor.magenta)
//        placeDot(position: CGPoint(x: 0, y: 100), color: UIColor.red)
//        placeDot(position: CGPoint(x: 0, y: 200), color: UIColor.green)
//        placeDot(position: CGPoint(x: 0, y: 300), color: UIColor.blue)
//        placeDot(position: CGPoint(x: 0, y: 400), color: UIColor.white)
//        placeDot(position: CGPoint(x: 0, y: 500), color: UIColor.yellow)
//        placeDot(position: CGPoint(x: 0, y: 520), color: UIColor.red)
//        placeDot(position: CGPoint(x: 0, y: 600), color: UIColor.orange)
//        placeDot(position: CGPoint(x: 0, y: 700), color: UIColor.purple)
//        placeDot(position: CGPoint(x: 0, y: 800), color: UIColor.red)
//
//        let topPhone = 1080.0 / 2.0
//        let topPad   = 1668.0 / 2.0
//
//        print("%%%%%%%%%%")
//        print(view.scene?.size)
//        print("Top iPhone: \(topPhone)")
//        print("Top iPad: \(topPad)\n")
//
//        print("Screen Size (nativeBounds): \(UIScreen.main.nativeBounds.size)")
//        print("Screen Size (bounds): \(UIScreen.main.bounds.size)")
//        print("Screen Size (nativeScale): \(UIScreen.main.nativeScale)")
//        print("%%%%%%%%%%")
        
        

        // ----------------------
        // Build the start button
        let buttonWidth  = 750
        let buttonHeight = 275
        startButton.texture = textureAtlas.textureNamed("green_button").copy() as! SKTexture
        startButton.size = CGSize(width: buttonWidth, height: buttonHeight)
        
        // Name the start node for touch detection
        startButton.name  = "StartButton"
        startButton.position = CGPoint(x: 0, y: 0)
        self.addChild(startButton)
        
        // Add text to the button
        let startText = SKLabelNode(fontNamed: HUDSettings.font)
        startText.text = "START GAME"
        startText.verticalAlignmentMode = .center
        startText.fontColor = UIColor.red
        startText.position = CGPoint(x: 0, y: 2)
        startText.fontSize = 100
        
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
        // Build the start button
        // ----------------------

        
        // ----------------------
        // Main Title
        let logoText = SKLabelNode(fontNamed: HUDSettings.font)
        logoText.text     = "Turd Herder"
        logoText.fontColor = UIColor.brown
        logoText.position = CGPoint(x: 0, y: (buttonHeight/2) + 50)
        logoText.fontSize = 288
        logoText.name = "logoText"
        self.addChild(logoText)
        // Main Logo
        // ----------------------
        
        
//        let logoTextBottom = SKLabelNode(fontNamed: HUDSettings.font)
//        logoTextBottom.text     = "Don't Make a Stink!"
//        logoTextBottom.fontColor = UIColor.brown
//        logoTextBottom.position = CGPoint(x: 0, y: 50)
//        logoTextBottom.fontSize = 80
//        self.addChild(logoTextBottom)

        
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
            
            print("\n\nScene Size 1: \(self.scene? .size)\n\n")
            
            // Locate the node at this location
            let nodeTouched = atPoint(location)
            
            if nodeTouched.name == "StartButton" {

                print("TOUCHED")
                
                let scene = GameScene(size: CGSize(width: 2048, height: 1536))
                scene.scaleMode = .fill
                self.view?.presentScene(scene)
                
//                if let scene = SKScene(fileNamed: "Scene") {
//                    scene.scaleMode = .aspectFill
//                    
//                    self.view?.presentScene(scene)
//                }
            }
        }
    }
    
    
    
}


