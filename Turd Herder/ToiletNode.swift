//
//  ToiletNode.swift
//  Turd Herder
//
//  Created by Brent Michalski on 8/18/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import SpriteKit

class ToiletNode: SKSpriteNode {

    var theToilet: SKNode!

//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//
//        print("\n\nToilet added to scene\n\n")
//
//        self.name = "toiletNode"
//
//
////        self.position = CGPoint(x: 100, y: 100)
////        print(self.children)
//
//
////        self.removeFromParent()
//
//    }
    
    
    
    
    
    func getTheNode() -> SKNode {
        
        if let scene = SKScene(fileNamed: "Toilet") {
            theToilet = scene.childNode(withName: "toilet_body")
        }
        
        return theToilet
        
    }
    
    
//    func didMoveToScene() {
//        print("\n\nToilet added to scene\n\n")
//
//
//
////        _ = SKTexture(imageNamed: "toilet_body")
//    }
    
    
    
    
}
