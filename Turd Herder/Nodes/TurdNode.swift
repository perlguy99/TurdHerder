//
//  TurdNode.swift
//  Turd Herder
//
//  Created by Brent Michalski on 7/30/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import UIKit
import SpriteKit

class TurdNode: SKSpriteNode {

    
//    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
//
//        return SKSpriteNode(imageNamed: "turd")
//
//        //        // Create and configure a node for the anchor added to the view's session.
//        //        let labelNode = SKLabelNode(text: "👾")
//        //        labelNode.horizontalAlignmentMode = .center
//        //        labelNode.verticalAlignmentMode = .center
//        //        return labelNode;
//    }
    

    init() {
        let texture = SKTexture(imageNamed: "turd")
        super.init(texture: texture, color: .clear, size: texture.size())
        name = "turd"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    func wasTapped() {
        print("TAPPED")
        
        let scaleOut = SKAction.scale(to: 4, duration: 0.2)
        let fadeOut  = SKAction.fadeOut(withDuration: 0.2)
        let group    = SKAction.group([scaleOut, fadeOut])
        let sequence = SKAction.sequence([group, SKAction.removeFromParent()])
        self.run(sequence)
    }
    
    
    
}
