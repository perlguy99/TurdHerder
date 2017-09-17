//
//  ViewController.swift
//  Turd Herder
//
//  Created by Brent Michalski on 7/6/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        runSession()
        
//        // Set the view's delegate
//        sceneView.delegate = self
        
        // Build the menu scene:
        let menuScene = MenuScene()
        menuScene.size = CGSize(width: 2048, height: 1536)
        menuScene.scaleMode = .fill

        // Show the menu
        sceneView.presentScene(menuScene)
    }
    

    
    public func runSession() {
//        print("runSesion")
        // Set the view's delegate
        sceneView.delegate = self
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
//        print("session.pause() from viewWillDisappear")
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSKViewDelegate

    // The Anchor that gets returned
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        return TurdNode()
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    
    func sessionWasInterrupted(_ session: ARSession) {
        
//        sceneView.session.pause()
//        sceneView.scene?.removeAllChildren()
//        sceneView.session.pause()
        
//        if let scene = sceneView.scene {
//            let children = scene.children
//
//            scene.removeAllChildren()
//            print("____________________")
//            print(children)
//            print("____________________")
//        }
        
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
//        sceneView.session.pause()
        
//        print("sessionWasInterrupted")
        
//        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
//            node.removeFromParentNode()
//        }
//
//        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
//        print("sessionInterruptionEnded")
//        runSession()
    }
}
