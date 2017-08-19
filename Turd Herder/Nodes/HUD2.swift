//
//  HUD2.swift
//  Turd Herder
//
//  Created by Brent Michalski on 8/17/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import SpriteKit

class HUD2: SKNode {
    var textureAtlas = SKTextureAtlas(named: "HUD")
    var turdAtlas    = SKTextureAtlas(named: "Turds")
    
    var hudOrigin = CGPoint(x: 20, y: 20)
    
    var turdNodes:[SKSpriteNode] = []
    let turdCountText = SKLabelNode(text: "00")
    
    func createHudNodes(screenSize: CGSize) {
        
        let labelText = SKLabelNode(text: "Remaining:")
        labelText.fontName = "Noteworthy-Bold"
        labelText.fontSize = 30
        labelText.position = CGPoint(x: hudOrigin.x, y: hudOrigin.y)
        
        let labelSize = labelText.frame.size
        
//        let turdIcon = SKSpriteNode(texture: turdAtlas.textureNamed("turd"))
//        let turdPosition = CGPoint(x: -hudOrigin.x + 23, y: hudOrigin.y - 23)
//        turdIcon.size = CGSize(width: 26, height: 26)
//        turdIcon.position = turdPosition
        
        turdCountText.fontName = "Noteworthy"
        
        let turdTextPosition = CGPoint(x: hudOrigin.x + labelSize.width, y: labelText.position.y)
        
        turdCountText.position = turdTextPosition
        
        print("\n\nLabelText Position: \(labelText.position)")
        print("TurdCount Position: \(turdCountText.position)\n\n")
        
//        LabelText Position: (20.0, 20.0)
//        TurdCount Position: (165.0, 20.0)
        
        
        turdCountText.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        turdCountText.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        self.addChild(labelText)
        self.addChild(turdCountText)
    }
    
    
    func setTurdCountDisplay(newTurdCount: Int) {
        let formatter = NumberFormatter()
        let number = NSNumber(value: newTurdCount)
        formatter.minimumIntegerDigits = 4
        
        if let turdStr = formatter.string(from: number) {
            turdCountText.text = turdStr
        }
    }
    
}

