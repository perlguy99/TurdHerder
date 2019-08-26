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

var arViewControllerInstance = ViewController()


// TODO: Make turds easier to tap
// TODO: Make Pause and Resume work
// TODO: Verify turds get laid using current ARKit methods

class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    
    // Create a session configuration
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arViewControllerInstance = self
        sceneView.delegate       = self
        
        resetTracking()
        
        // Build the menu scene:
        let menuScene       = MenuScene()
        menuScene.size      = CGSize(width : 2048, height : 1536)
        menuScene.scaleMode = .fill

        // Show the menu
        sceneView.presentScene(menuScene)
    }
    
    
    public func resetTracking() {
        
        print("resetTracking()")
        
        // Run the view's session
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
//        sceneView.session.pause()
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
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        print("pause")
        sceneView.session.pause()
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        print("resume")
        sceneView.session.run(configuration)
    }
}
