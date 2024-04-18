//
//  CameraRequiredScene.swift
//  Turd Herder
//
//  Created by Brent Michalski on 9/1/19.
//  Copyright © 2019 Brent Michalski. All rights reserved.
//

import SpriteKit
import StoreKit

class CameraRequiredScene: SKScene {

    let hud = HUD()
    
    override func didMove(to view: SKView) {
        
        self.name = "CameraRequiredScene"
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.addChild(hud)
        
        let turdGuy = SKSpriteNode(imageNamed: "credits_turd")
        turdGuy.zPosition = 1000
        turdGuy.setScale(0.23)
        addChild(turdGuy)
        
        let yPos = scene?.frame.maxY
        
        let row1 = SKLabelNode(text: "Camera access is REQUIRED")
        row1.fontColor = UIColor.brown
        row1.fontName  = HUDSettings.font
        row1.fontSize  = 60
        row1.position  = CGPoint(x : 0, y : yPos! - 260)
        row1.zPosition = 1500
        self.addChild(row1)
        
        let row2 = SKLabelNode(text: "if you want to Herd Turds!")
        row2.fontColor = UIColor.brown
        row2.fontName  = HUDSettings.font
        row2.fontSize  = 60
        row2.position  = CGPoint(x : 0, y : yPos! - 320)
        row2.zPosition = 1500
        self.addChild(row2)

        let row3 = SKLabelNode(text: "Turn Camera On")
        row3.name      = "SETTINGS"
        row3.fontColor = UIColor.systemBlue
        row3.fontName  = HUDSettings.font
        row3.fontSize  = 60
        row3.position  = CGPoint(x : 0, y : yPos! - 400)
        row3.zPosition = 1500
        self.addChild(row3)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let settingsAppURL = URL(string: UIApplication.openSettingsURLString)!
        
        for touch in (touches) {
            // find the location of the touch
            let location = touch.location(in: self)
            
            // Locate the node at this location
            let nodeTouched = atPoint(location)
            
            if nodeTouched.name == "SETTINGS" {
                UIApplication.shared.open(settingsAppURL, options: [:], completionHandler: nil)
            }
        }
    }
    


}

