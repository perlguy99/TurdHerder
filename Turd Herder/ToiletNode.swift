//
//  ToiletNode.swift
//  Turd Herder
//
//  Created by Brent Michalski on 8/18/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import SpriteKit

class ToiletNode {
    
    class func getToilet() -> SKNode {
        
        // Pulse the start text in and out gently
        let fumesPulse = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.3, duration: 1.5),
            SKAction.fadeAlpha(to: 1, duration: 1.5)
            ])
        
        let rotateLeft   = SKAction.rotate(byAngle: CGFloat(7.0).degreesToRadians(), duration: 1.5)
        let rotateRight  = SKAction.rotate(byAngle: CGFloat(-7.0).degreesToRadians(), duration: 1.5)
        let backAndForth = SKAction.sequence([rotateLeft, rotateRight])
        let grouped      = SKAction.group([backAndForth, fumesPulse])
        let fumeAction   = SKAction.repeatForever(grouped)
        
        let toilet = SKSpriteNode(imageNamed: "toilet_plain1")
        let fumes  = SKSpriteNode(imageNamed: "fumes1")
        
        toilet.position = CGPoint(x: 0, y: 0)
        fumes.position  = CGPoint(x: -50, y: 75)
        fumes.zPosition = 5
        fumes.run(fumeAction)
        
        let theToilet = SKNode()
        theToilet.addChild(toilet)
        theToilet.addChild(fumes)
        
        theToilet.name = "Toilet"
        return theToilet
    }
    
}
