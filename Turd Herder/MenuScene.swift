//
//  MenuScene.swift
//  Turd Herder
//
//  Created by Brent Michalski on 8/17/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    let hud = HUD()
    
    let backgroundMusicTrack = [
        "8-Bit-Puzzler.mp3",
        "Disco-Ants-Go-Clubbin_Looping.mp3",
        "Farty-Crooks_Looping.mp3",
        "Farty-McSty.mp3",
        ]

    let shortFarts = [
        SKAction.playSoundFileNamed("fart2.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart3.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart4.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart6.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart7.mp3", waitForCompletion: false),
        SKAction.playSoundFileNamed("fart8.mp3", waitForCompletion: false),
        ]

    
    func buildStartButton() -> SKSpriteNode {
        let startGameButton = SKSpriteNode(imageNamed : "start_game")

        startGameButton.zPosition = 1000
        startGameButton.position  = .zero
        startGameButton.name      = "startGameButton"
        startGameButton.setScale(0)

        return startGameButton
    }

    
    // Instantiate a sprite node for the start button
    override func didMove(to view: SKView) {
        self.name = "MenuScene"
        self.addChild(hud)
        
        hud.playBackgroundMusic(name: backgroundMusicTrack[2])
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // ----------------------
        // Build the start button
        let buttonHeight    = 225
        let startGameButton = buildStartButton()
        self.addChild(startGameButton)
        
        // Pulse the start text in and out gently
        let pulseAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.6, duration: 0.5),
            SKAction.fadeAlpha(to: 1, duration: 0.9)
            ])
        startGameButton.run(SKAction.repeatForever(pulseAction))
        // Build the start button
        // ----------------------

        
        // ----------------------
        // Main Title
        let turd_logo   = SKSpriteNode(imageNamed: "turd_logo_old")
        let herder_logo = SKSpriteNode(imageNamed: "herder_logo")
        let stink_logo  = SKSpriteNode(imageNamed: "dont_make_a_stink")
        
        turd_logo.setScale(0)
        turd_logo.zPosition = 1000
        turd_logo.name = "turd_logo_old"
        
        herder_logo.setScale(0)
        herder_logo.zPosition = 1000
        herder_logo.name = "herder_logo"
        
        stink_logo.setScale(0)
        stink_logo.zPosition = 1000
        stink_logo.name = "stink_logo"
        
        let titleXturd     = CGFloat(-400.0)
        let titleYturd     = CGFloat((buttonHeight/2) + 350)
        let titleXherder   = CGFloat(400.0)
        let titleYherder   = CGFloat((buttonHeight/2) + 350)
        let titleXstink    = CGFloat(0)
        let titleYstink    = CGFloat((buttonHeight/2) + 125)
        
        turd_logo.position   = CGPoint(x : titleXturd,   y : titleYturd)
        herder_logo.position = CGPoint(x : titleXherder, y : titleYherder)
        stink_logo.position  = CGPoint(x : titleXstink,  y : titleYstink)
        
        self.addChild(turd_logo)
        self.addChild(herder_logo)
        self.addChild(stink_logo)
        
        let scaleUp          = SKAction.scale(to: 2.5, duration: 1.0)
        let scaleDown        = SKAction.scale(to: 2.0, duration: 0.25)
        let scaleDownS       = SKAction.scale(to: 1.8, duration: 0.25)

        scaleDown.timingMode = .easeInEaseOut
        scaleUp.timingMode   = .easeInEaseOut
        
        let shakeTurd   = SKAction.screenShakeWithNode(turd_logo, amount: CGPoint(x: 20, y: 20), oscillations: 15, duration: 2)
        let shakeHerder = SKAction.screenShakeWithNode(herder_logo, amount: CGPoint(x: 20, y: 20), oscillations: 15, duration: 2)
        let shakeStink  = SKAction.screenShakeWithNode(stink_logo, amount: CGPoint(x: 20, y: 20), oscillations: 15, duration: 2)
        
        let sequenceTurd   = SKAction.sequence([scaleUp, scaleDown, shakeTurd])
        let sequenceHerder = SKAction.sequence([scaleUp, scaleDown, shakeHerder])

        // Run the sequences
        turd_logo.run(sequenceTurd)
        herder_logo.run(sequenceHerder)

        if gameSoundOn {
            let randomFart = Int.random(shortFarts.count)
            let sequenceS  = SKAction.sequence([scaleUp, scaleDownS, shortFarts[randomFart], shakeStink])
            stink_logo.run(SKAction.afterDelay(2.0, performAction: sequenceS))
        }
        else {
            let sequenceS = SKAction.sequence([scaleUp, scaleDownS, shakeStink])
            stink_logo.run(SKAction.afterDelay(2.0, performAction: sequenceS))
        }
        
        // Now, scale the start button into position
        let scaleStartUp   = SKAction.scale(to: 1.50, duration: 1.0)
        let scaleStartDown = SKAction.scale(to: 1.25, duration: 0.5)
        
        startGameButton.run(SKAction.afterDelay(3.0, performAction: SKAction.sequence([scaleStartUp, scaleStartDown])))
        
        let theToilet = ToiletNode.getToilet()
        theToilet.position = CGPoint(x: 0, y: -350)
        
        self.addChild(theToilet)
        
        hud.addMenuButtons()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in (touches) {
            // find the location of the touch
            let location = touch.location(in: self)
            
            // Locate the node at this location
            let nodeTouched = atPoint(location)
            
            switch nodeTouched.name {
            case "startGameButton":
                startGame()
            case HUDButtons.about:
                showAbout()
            case HUDButtons.soundOn:
                swapSoundButtons()
            case HUDButtons.soundOff:
                swapSoundButtons()
            case HUDButtons.musicOn:
                turnMusicOn()
            case HUDButtons.musicOff:
                turnMusicOff()
            default: break
            }
        }
    }


    fileprivate func buttonToggle(nodeName: String) {
        if let node = childNode(withName: nodeName) {
            if node.isHidden == true {
                node.isHidden = false
            }
            else {
                node.isHidden = true
            }
            
            if node.name == HUDButtons.soundOn {
                gameSoundOn = !node.isHidden
            }
            if node.name == HUDButtons.musicOn {
                gameMusicOn = !node.isHidden
            }
        }
    }

    
    func swapSoundButtons() {
        print("swapSoundButtons()")
        buttonToggle(nodeName: HUDButtons.soundOn)
        buttonToggle(nodeName: HUDButtons.soundOff)
    }

    
    func swapMusicButtons() {
        print("swapMusicButtons()")
        buttonToggle(nodeName: HUDButtons.musicOn)
        buttonToggle(nodeName: HUDButtons.musicOff)
    }
   
    
    func showAbout() {
        print("showAbout()")
        
        let scene = CreditsScene(size: CGSize(width: 2048, height: 1536))
        scene.scaleMode = .fill
        self.view?.presentScene(scene)
    }
    
    
    func startGame() {
        print("startGame()")
        
        hud.stopBackgroundMusic()
        
        let scene = GameScene(size: CGSize(width: 2048, height: 1536))
        scene.scaleMode = .fill
        self.view?.presentScene(scene)
    }
    
    
    func turnMusicOn() {
        print("turnMusicOn()")
        
        swapMusicButtons()
        
        if gameMusicOn == false {
            hud.stopBackgroundMusic()
        }
        else {
            hud.playBackgroundMusic(name: backgroundMusicTrack[2])
        }
    }
 
    
    func turnMusicOff() {
        print("turnMusicOff()")
        
        swapMusicButtons()
        
        if gameMusicOn == false {
            hud.stopBackgroundMusic()
        }
        else {
            hud.playBackgroundMusic(name: backgroundMusicTrack[2])
        }
        
    }
    
    
}


