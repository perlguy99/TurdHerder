//
//  Credits.swift
//  Turd Herder
//
//  Created by Brent Michalski on 9/11/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import SpriteKit
import StoreKit

class CreditsScene: SKScene, UIWebViewDelegate {

    let hud = HUD()
    
    override func didMove(to view: SKView) {
//        SKStoreReviewController.requestReview()
        
        self.name = "CreditsScene"
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.addChild(hud)
        
        let turdGuy = SKSpriteNode(imageNamed: "credits_turd")
        turdGuy.zPosition = 1000
        turdGuy.setScale(0.23)
        addChild(turdGuy)
        
        let yPos = scene?.frame.maxY
        
        let byLabel = SKLabelNode(text: "Game by Brent Michalski")
        byLabel.fontColor = UIColor.brown
        byLabel.fontName = HUDSettings.font
        byLabel.fontSize = 60
        byLabel.position = CGPoint(x: 0, y: yPos! - 170)
        byLabel.zPosition = 1500
        self.addChild(byLabel)

        let byLabel2 = SKLabelNode(text: "https://www.KingOfFarts.com")
        byLabel2.fontColor = UIColor.brown
        byLabel2.fontName = HUDSettings.font
        byLabel2.fontSize = 40
        byLabel2.position = CGPoint(x: 0, y: yPos! - 210)
        byLabel2.zPosition = 1500
        self.addChild(byLabel2)

        let musicLabel = SKLabelNode(text: "Music by Eric Matyas (https://www.soundimage.org)")
        musicLabel.fontColor = UIColor.brown
        musicLabel.fontName = HUDSettings.font
        musicLabel.fontSize = 35
        musicLabel.position = CGPoint(x: 0, y: yPos! - 280)
        musicLabel.zPosition = 1500
        self.addChild(musicLabel)

        let helpers = SKLabelNode(text: "Title Helpers: Andy Darrah, Chuck Scoggins, Ron Black,\nCindy Snider, Dave Kasprzyk, Tim Van Farren")
        helpers.fontColor = UIColor.brown
        helpers.numberOfLines = 2
        helpers.horizontalAlignmentMode = .center
        helpers.verticalAlignmentMode = .top
        helpers.fontName = HUDSettings.font
        helpers.fontSize = 30
        helpers.position = CGPoint(x: 0, y: yPos! - 300)
        helpers.zPosition = 1500
        self.addChild(helpers)

        print(helpers.frame)
        
        let fontLabel = SKLabelNode(text: "Freckle Face Font Copyright (c) 2012, Brian J. Bonislawsky\nDBA Astigmatic (AOETI) (astigma@astigmatic.com)\nwith Reserved Font Name 'Freckle Face'\nThis Font Software is licensed under the SIL Open Font License, Version 1.1.\nThis license is available with a FAQ at: https://scripts.sil.org/OFL")
        
        fontLabel.fontColor = UIColor.black
        fontLabel.numberOfLines = 0
        fontLabel.horizontalAlignmentMode = .center
        fontLabel.verticalAlignmentMode = .bottom
        fontLabel.fontName = "Arial"
        fontLabel.fontSize = 25
        fontLabel.position = CGPoint(x: 0, y: yPos! - 575)
        fontLabel.zPosition = 1500
        self.addChild(fontLabel)

        hud.addBackButton()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            // find the location of the touch
            let location = touch.location(in: self)
            
            // Locate the node at this location
            let nodeTouched = atPoint(location)
            
            // Check for a touch on the Start Button
            if nodeTouched.name == HUDButtons.back {
                
                let scene = MenuScene(size: CGSize(width: 2048, height: 1536))
                scene.scaleMode = .fill
                self.view?.presentScene(scene)
            }
        }
    }
    


}

