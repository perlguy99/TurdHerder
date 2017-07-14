//
//  Scene.swift
//  Turd Herder
//
//  Created by Brent Michalski on 7/6/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

// TODO: Tap anywhere to continue
// TODO: Sound effects
// TODO: Background music
// TODO: Message to hold device in proper orientation?


import SpriteKit
import ARKit
import GameplayKit

class Scene: SKScene {
    let maxTargets = 2
    var hud = HUD()
    
    let startTime = Date()
    let remainingLabel = SKLabelNode()
    let timeLabel = SKLabelNode()
    var timer: Timer?
    var targetsCreated = 0
    var targetCount = 0 {
        didSet {
            remainingLabel.text = "Remaining: \(targetCount)"
        }
    }
    
    override func didMove(to view: SKView) {
        // Setup your scene here

        setupGame()
    }
    
    func setupGame() {
        setupRemainingLabel()
        targetCount = 0
        
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            self.createTarget()
        }
    }
    
    func setupRemainingLabel() {
        guard let myView = self.view else { return }
        
        remainingLabel.fontSize = HUDSettings.fontSize
        remainingLabel.fontName = HUDSettings.font
        remainingLabel.color    = .white
        remainingLabel.position = CGPoint(x: 0, y: myView.frame.midY - 50)
        addChild(remainingLabel)
    }
    
    func createTarget() {
        print("Call to createTarget()")
        
        if targetsCreated == maxTargets {
            timer?.invalidate()
            timer = nil
            return
        }
        
        targetsCreated += 1
        targetCount    += 1
        
        // find the scene view we are drawing into
        guard let sceneView = self.view as? ARSKView else { return }
        
        // get access to a random number generator
        let random = GKRandomSource.sharedRandom()
        
        // create a random X rotation
        let xRotation = simd_float4x4(SCNMatrix4MakeRotation(Float.pi * 2 * random.nextUniform(), 1, 0, 0))
        
        // create a random Y rotation
        let yRotation = simd_float4x4(SCNMatrix4MakeRotation(Float.pi * 2 * random.nextUniform(), 0, 1, 0))
        
        // combine them together
        let rotation = simd_mul(xRotation, yRotation)
        
        // move forward 1.5 meters into the screen
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -1.5
        
        // combine that with the rotation
        let transform = simd_mul(rotation, translation)
        
        // create an anchor at the finished position
        let anchor = ARAnchor(transform: transform)
        sceneView.session.add(anchor: anchor)
        
        
    }
    
    func displayTimeTakenLabel() {
        guard let myView = self.view else { return }
        
        let timeTaken = Date().timeIntervalSince(startTime)
        timeLabel.text = "Time taken: \(Int(timeTaken)) seconds"
        timeLabel.fontSize = HUDSettings.fontSize
        timeLabel.fontName = HUDSettings.font
        timeLabel.color = .white
        timeLabel.position = CGPoint(x: 0, y: -myView.frame.midY + 50)
        
        addChild(timeLabel)

    }
    
    func gameOver() {
        remainingLabel.removeFromParent()
        
        let gameOver = SKSpriteNode(imageNamed: "gameOver")
        addChild(gameOver)

        displayTimeTakenLabel()

    }
    
    
    func restartGame() {
        timeLabel.removeFromParent()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        let hit = nodes(at: location)
        
        if let sprite = hit.first {
            let scaleOut = SKAction.scale(to: 2, duration: 0.2)
            let fadeOut = SKAction.fadeOut(withDuration: 0.2)
            let group = SKAction.group([scaleOut, fadeOut])
            let sequence = SKAction.sequence([group, SKAction.removeFromParent()])
            sprite.run(sequence)
            
            targetCount -= 1
            
            if targetsCreated == maxTargets && targetCount == 0 {
                gameOver()
            }
        }
        
    }
}

