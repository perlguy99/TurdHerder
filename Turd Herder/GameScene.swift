//
//  GameScene.swift
//  Turd Herder
//
//  Created by Brent Michalski on 8/31/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import SpriteKit
import ARKit
import GameplayKit


class GameScene: SKScene {
    var targetCreationRate:TimeInterval = 0.25
    
    let maxTargets       = 2
    var currentFartIndex = 0
    
    var hud = HUD()
    
    var toiletNode: ToiletNode!
    
    var startTime: Date!
    var timer: Timer?
    var targetsCreated = 0
    var targetCount = 0 {
        didSet {
            hud.updateTurdsRemainingLabel(turds: targetCount)
        }
    }
    
    var gameState: GameState = .initial {
        didSet {
            if oldValue != gameState {
                hud.updateGameState(from: oldValue, to: gameState)
                
                if gameState == .win {
                    gameOver()
                }
            }
        }
    }
    
    
    // Sound effects
    let shortFarts = [
        SKAction.playSoundFileNamed("fart2.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart3.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart4.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart5.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart6.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart7.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart8.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart9.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart10.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart11.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart12.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart13.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart14.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart16.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart17.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart18.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart20.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart21.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart23.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart24.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart25.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart26.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart27.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart28.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart34.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart36.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart38.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart39.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart40.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart41.wav", waitForCompletion: false),
        ]


    let targetCreationFarts = [
        SKAction.playSoundFileNamed("fart27.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart35.wav", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart13.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart20.wav", waitForCompletion: false),
        ]

    let toiletFlushHighScore = SKAction.playSoundFileNamed("toilet_flush.wav", waitForCompletion: false)
    let counterFart = SKAction.playSoundFileNamed("fart37.wav", waitForCompletion: false)

    let backgroundMusicTrack = [
        "8-Bit-Puzzler.mp3",
        "Disco-Ants-Go-Clubbin_Looping.mp3",
        "Farty-Crooks_Looping.mp3",
        "Farty-McSty.mp3",
    ]
    
    override func didMove(to view: SKView) {
        hud.playBackgroundMusic(name: backgroundMusicTrack[3])
        startGame()
    }
    
    func startGame() {
        targetCount    = 0
        targetsCreated = 0
        gameState      = .start
//        startTime      = Date()
        
        doCountdown()
        
//        self.setupHUD(startTime: Date())
        
//        self.addChild(hud)
        
        self.run(SKAction.afterDelay(3.0, runBlock: {
            self.startCreatingTargets()
            self.setupHUD(startTime: Date())
            self.hud.addNukeButton()
        }))
    }
    
    
    func startCreatingTargets() {
        gameState = .playing
        
        timer = Timer.scheduledTimer(withTimeInterval: targetCreationRate, repeats: true) { timer in
            self.createTarget()
        }
    }
    
    
    func setupHUD(startTime: Date) {
        self.addChild(hud)
        hud.addTimer(startTime: startTime)
        hud.addRemainingTurdsLabel()
    }
    
    
    func createTarget() {
        if targetsCreated == maxTargets {
            timer?.invalidate()
            timer = nil
            return
        }
        
        if gameSoundOn {
            let randomFart = Int.random(targetCreationFarts.count)
            run(targetCreationFarts[randomFart])
        }
        
        targetsCreated += 1
        targetCount    += 1
        
        // find the scene view we are drawing into
        guard let sceneView = self.view as? ARSKView else { return }
        
        // get access to a random number generator
        let random = GKRandomSource.sharedRandom()
        
        // create a random X rotation
//        let xRotation = simd_float4x4(SCNMatrix4MakeRotation(Float.pi * 2 * random.nextUniform(), 1, 0, 0))
        let xRotation = simd_float4x4(SCNMatrix4MakeRotation(0, 1, 0, 0))
        
        // create a random Y rotation
//        let yRotation = simd_float4x4(SCNMatrix4MakeRotation(Float.pi * 2 * random.nextUniform(), 0, 1, 0))
        let yRotation = simd_float4x4(SCNMatrix4MakeRotation(0, 0, 1, 0))
        
        // combine them together
        let rotation = simd_mul(xRotation, yRotation)
        
        // move forward 1.5 meters into the screen
        var translation = matrix_identity_float4x4
//        translation.columns.3.z = -1.5
        translation.columns.3.z = -2.0
        
        // combine that with the rotation
        let transform = simd_mul(rotation, translation)
        
        // create an anchor at the finished position
        let anchor = ARAnchor(transform: transform)
        sceneView.session.add(anchor: anchor)
    }
    
    
    func gameOver() {
        print("\n\nGame Over... FLUSHING\n\n")
        hud.playBackgroundMusic(name: backgroundMusicTrack[2])
        
        if gameSoundOn {
            run(toiletFlushHighScore)
        }
        
        hud.addBackButton()
    }
    
    
    func checkEndGame() {
        if targetsCreated == maxTargets && targetCount == 0 {
            gameState = .win
        }
    }

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if hud.startTime != nil {
            hud.updateTimer()
        }
        
        checkEndGame()
    }
    
    
    func doCountdown() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let three = SKSpriteNode(imageNamed: "3").copy() as? SKSpriteNode
        let two   = SKSpriteNode(imageNamed: "2").copy() as? SKSpriteNode
        let one   = SKSpriteNode(imageNamed: "1").copy() as? SKSpriteNode
        
        three?.isHidden = true
        two?.isHidden = true
        one?.isHidden = true
        
        three?.setScale(5.0)
        two?.setScale(5.0)
        one?.setScale(5.0)
        
        three?.position = .zero
        two?.position   = .zero
        one?.position   = .zero
        
        scene.addChild(three!)
        scene.addChild(two!)
        scene.addChild(one!)
        
        let scaleOut        = SKAction.scale(to: 0, duration: 1)
        let actionUnhide    = SKAction.unhide()
        scaleOut.timingMode = .easeInEaseOut
        
        print("\ndoCountdown()\n")
        print(scene.size)
        
        if gameSoundOn {
            three!.run(SKAction.sequence([actionUnhide, counterFart, scaleOut, SKAction.removeFromParent()]))
            two!.run(SKAction.sequence([SKAction.wait(forDuration: 1), actionUnhide, counterFart, scaleOut, SKAction.removeFromParent()]))
            one!.run(SKAction.sequence([SKAction.wait(forDuration: 2), actionUnhide, counterFart, scaleOut, SKAction.removeFromParent()]))
        }
        else {
            three!.run(SKAction.sequence([actionUnhide, scaleOut, SKAction.removeFromParent()]))
            two!.run(SKAction.sequence([SKAction.wait(forDuration: 1), actionUnhide, scaleOut, SKAction.removeFromParent()]))
            one!.run(SKAction.sequence([SKAction.wait(forDuration: 2), actionUnhide, scaleOut, SKAction.removeFromParent()]))
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        print("Game State: \(gameState)")
        
        let location = touch.location(in: self)
        let hit      = nodes(at: location)
        
        // Locate the node at this location
        let nodeTouched = atPoint(location)
        
        
        // Play Again
        if nodeTouched.name == "playAgainButton" {
            self.gameState = .restart
            
            print("PlayAgainButton TOUCHED")
            
            let scene = GameScene(size: CGSize(width: 2048, height: 1536))
            scene.scaleMode = .fill
            self.view?.presentScene(scene)
        }
        
        
        // Main Menu
        if nodeTouched.name == HUDButtons.about {
            hud.stopBackgroundMusic()
            
            let scene = MenuScene(size: CGSize(width: 2048, height: 1536))
            scene.scaleMode = .fill
            self.gameState = .initial
            self.view?.presentScene(scene)
        }

        
        if nodeTouched.name == HUDButtons.nuke {
            
            gameState = .pause
            
            let alert = UIAlertController(title: "Quit Turd Herding?", message: "Are you sure you want to quit?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                let scene = MenuScene(size: CGSize(width: 2048, height: 1536))
                scene.scaleMode = .fill
                self.gameState = .initial
                self.view?.presentScene(scene)
            }) )
            
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action) in
                self.gameState = .playing
            }))
            
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }

        
        
        // Tapped a Turd
        if let sprite = hit.first as? TurdNode {

            if gameSoundOn {
                let randomFart = Int.random(shortFarts.count)
                run(shortFarts[randomFart])
            }
            
            sprite.wasTapped()
            targetCount -= 1
        }
    }
    
}


