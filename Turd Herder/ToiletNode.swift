//
//  ToiletNode.swift
//  Turd Herder
//
//  Created by Brent Michalski on 8/18/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import SpriteKit

class ToiletNode: SKSpriteNode, EventListenerNode {

    func didMoveToScene() {
        print("Toilet added to scene")
        
        _ = SKTexture(imageNamed: "toilet_body")
    }
    
    
    
    
}
