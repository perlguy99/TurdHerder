//
//  HUD.swift
//  Turd Herder
//
//  Created by Brent Michalski on 7/13/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import SpriteKit

enum HUDMessages {
    static let tapToStart = "Tap to Start"
    static let win = "You Win!"
    static let lose = "Out of Time!"
    static let yourTime = "Your Time: "
}


enum HUDSettings {
    static let font = "HelveticaNeue"
    static let fontSize: CGFloat = 30
}



class HUD: SKNode {
    
    override init() {
        super.init()
        name = "HUD"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addRemainingInfo(position: CGPoint, fontSize: CGFloat = HUDSettings.fontSize) {
        let label: SKLabelNode
        label = SKLabelNode(fontNamed: HUDSettings.font)
        label.name = "remainingInfo"
        
        addChild(label)
        label.fontSize = fontSize
        label.position = position
        
    }
    
    
    func updateRemainingInfo(message: String) {
        self
        
    }
    
}
