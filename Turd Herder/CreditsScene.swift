//
//  Credits.swift
//  Turd Herder
//
//  Created by Brent Michalski on 9/11/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import SpriteKit

class CreditsScene: SKScene, UIWebViewDelegate {

    let hud = HUD()
    
    override func didMove(to view: SKView) {
        self.name = "CreditsScene"
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.addChild(hud)
        
////        let frame = CGRect(x: (view.frame.size.width / 2) - 400, y: (view.frame.size.height / 2) - 300, width: 800, height: 600)
//        let frame = CGRect(x: 0, y: 0, width: 800, height: 600)
//        let webView = UIWebView(frame: frame)
//        webView.backgroundColor = UIColor.clear
//        webView.loadRequest(URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: "FF_FontAttribute", ofType: "txt")!)))
//        webView.delegate = self
//        view.addSubview(webView)
        
        let backgroundShape = SKShapeNode(rectOf: CGSize(width: 1200, height: 800) , cornerRadius: 8.0)
        backgroundShape.fillColor = UIColor.brown
        backgroundShape.alpha = 0.5
        self.addChild(backgroundShape)
        
        let byLabel = SKLabelNode(text: "Game by Brent Michalski")
        byLabel.fontColor = UIColor.yellow
        byLabel.fontName = HUDSettings.font
        byLabel.fontSize = 60
        byLabel.position = CGPoint(x: 0, y: 300)
        backgroundShape.addChild(byLabel)

//        let labelSize = byLabel.frame.size
        
        let musicLabel = SKLabelNode(text: "Music by Eric Matyas (https://www.soundimage.org)")
        musicLabel.fontColor = UIColor.white
        musicLabel.fontName = HUDSettings.font
        musicLabel.fontSize = 40
        musicLabel.position = CGPoint(x: 0, y: 200)
        backgroundShape.addChild(musicLabel)

        let helpers = SKLabelNode(text: "Title Helpers: Andy Darrah, Chuck Scoggins, Ron Black,\nCindy Snider, Dave Kasprzyk, Tim Van Farren")
        helpers.fontColor = UIColor.white
        helpers.numberOfLines = 2
        helpers.horizontalAlignmentMode = .center
        helpers.verticalAlignmentMode = .top
        helpers.fontName = HUDSettings.font
        helpers.fontSize = 40
        helpers.position = CGPoint(x: 0, y: 100)
        backgroundShape.addChild(helpers)

        print(helpers.frame)
        
        let fontLabel = SKLabelNode(text: "Freckle Face Font\nCopyright (c) 2012, Brian J. Bonislawsky DBA Astigmatic\n(AOETI) (astigma@astigmatic.com)\nwith Reserved Font Name 'Freckle Face'\nThis Font Software is licensed under the SIL Open Font License, Version 1.1.\nThis license is available with a FAQ at: https://scripts.sil.org/OFL")
        
        fontLabel.fontColor = UIColor.white
        fontLabel.numberOfLines = 0
        fontLabel.horizontalAlignmentMode = .center
        fontLabel.verticalAlignmentMode = .bottom
        fontLabel.fontName = "Arial"
        fontLabel.fontSize = 30
        fontLabel.position = CGPoint(x: 0, y: -300)
        backgroundShape.addChild(fontLabel)
        
        
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

