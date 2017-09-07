////
////  MessageBox.swift
////  Turd Herder
////
////  Created by Brent Michalski on 8/18/17.
////  Copyright © 2017 Brent Michalski. All rights reserved.
////
//
//import SpriteKit
//
//class MessageBox: SKNode {
//
////    var toiletNode: ToiletNode!
//
//
//
//
////    var toiletNode = ToiletNode().childNode(withName: "//toilet_body")!
//
//
//
////    let toiletNode = SKSpriteNode(fileNamed: "Toilet")!.childNode(withName: "toilet_body")!
////    let toiletNode = SKSpriteNode(fileNamed: "Toilet")!
//    let textureAtlas:SKTextureAtlas = SKTextureAtlas(named: "HUD")
//
//
//    func createMessageBox(size: CGSize, message: String) {
//
//        // Add any background images, set zPosition to -1
//        let background = SKSpriteNode()
//        background.texture = textureAtlas.textureNamed("button")
//        background.name = "background"
//        background.size = size
//        background.zPosition = -1
//        background.position = .zero
//        self.addChild(background)
//
//        let message1 = SKLabelNode()
//        message1.fontName = HUDSettings.font
//        message1.fontColor = HUDSettings.fontColor
//        message1.fontSize = 50
//        message1.text = message
//        message1.verticalAlignmentMode = .center
//        message1.position = CGPoint(x: 0, y: 50)
//
//        self.addChild(message1)
//    }
//
////    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
////        for touch in (touches) {
////            // find the location of the touch
////            let location = touch.location(in: self)
////
////            // Locate the node at this location
////            let nodeTouched = atPoint(location)
////
////            if nodeTouched.name == "StartButton" {
////                if let scene = SKScene(fileNamed: "Scene") {
////                    self.view?.presentScene(scene)
////                }
////            }
////        }
////    }
////
//
//
//}
//
//
