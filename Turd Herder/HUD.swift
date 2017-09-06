//
//  HUD.swift
//  Turd Herder
//
//  Created by Brent Michalski on 7/13/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import SpriteKit

enum HUDMessages {
    static let tapToStart = "Tap to Start"
    static let win        = "You Win!"
    static let lose       = "Out of Time!"
    static let playAgain  = "Tap Anywhere to Play Again"
    static let newRecord  = "A New Record Time of: "
    static let three      = "3"
    static let two        = "2"
    static let one        = "1"
    static let go         = "Go"
}


enum HUDSettings {
//    static let font               = "turds"
    static let font               = "Freckle Face"
//    static let font               = "Dingle Berries"
//    static let font               = "StayPuft"
    
    static let fontColor: UIColor        = UIColor.brown
    static let messageFontColor: UIColor = UIColor.yellow
    static let titleSize: CGFloat        = 150
    static let fontSize: CGFloat         = 100
    static let messageTitleSize: CGFloat = 100
    static let messageFontSize: CGFloat  = 60
    static let messageZposition: CGFloat = 50
}



class HUD: SKNode {
    
    var remainingLabel: SKLabelNode?
    var timerLabel: SKLabelNode?
    var startTime: Date!
    var timeTakenLabel: SKLabelNode?
    
    var textureAtlas: SKTextureAtlas!
    
    var hudImage: SKSpriteNode?
    
    var bestTimeFlag: Bool?
    
    let counterFart = SKAction.playSoundFileNamed("AirBiscuit.mp3", waitForCompletion: false)
    
    let winningTitles = [
        "Great Job Turd Herder",
        "Well Done Turd Herder",
        "Awesome Turd Herding",
    ]
    
    let winningMessages = [
        "You must have been practicing your turd herding skills!",
        "Whoa, you really ripped one that time!",
    ]
    

    
    
    
    override init() {
        super.init()
        name = "HUD"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    func updateGameState(from: GameState, to: GameState) {
        clearUI(gameState: from)
        updateUI(gameState: to)
    }
    
    
    
    func checkForBestTime() {
        
        print("Checking for best time")
        // get best time stored in user defaults
//        if let bestTime = UserDefaults.standard.
        
        
        // compare it with the current score
        
        // Better time?
        // Update the user defaults
        // Set high score flag
        
        
    }
    
    
    
    private func updateUI(gameState: GameState) {
        // Uses the "TO" GameState value
        // add messages for the new state
        switch gameState {
        case .initial:
            print("++ updateUI.initial")
            
        case .start:
            print("++ updateUI.start")
            add(message: HUDMessages.tapToStart, position: .zero)

        case .playing:
            print("++ updateUI.playing")
            
        case .win:
            print("++ updateUI.win")
            
//            addHUDImage(name: "gameOver", position: .zero)
//            addTimeTakenLabel()
            
            remove(message: "Timer")
            remove(message: "RemainingTurdsLabel")
            remove(message: "MenuBackground")
            
//            let randomMessage = Int.random(winningTitles.count)
            let titleText = winningTitles[Int.random(winningTitles.count)]
            
            addMessageBox(title: titleText, message1: getTimeTakenText(), message2: "Message 2")
            
//            addPlayAgainMessage()
            
            
        case .restart:
            print("++ updateUI.restart")
            add(message: HUDMessages.lose, position: .zero)

        case .pause:
            print("++ updateUI.pause")
            
        }
    }
    
    
    private func clearUI(gameState: GameState) {
        // Uses the "FROM" GameState value
        // clear previous state messages
        switch gameState {
            
        case .initial:
            print("-- clearUI.initial")

        case .start:
            print("-- clearUI.start")
            remove(message: HUDMessages.tapToStart)

        case .playing:
            print("-- clearUI.playing")
            
        case .win:
            print("-- clearUI.win")
            remove(message: HUDMessages.win)
            
        case .restart:
            print("-- clearUI.restart")
            
        case .pause:
            print("-- clearUI.pause")
            
        }
        
    }
    
    
    private func remove(message: String) {
        print("\n\nRemoving \(message) from the scene\n\n")
        childNode(withName: message)?.removeFromParent()
    }
    
    
    
    @objc func changeHUDImage() {
        remove(message: "gameOver")
        addHUDImage(name: "tapAnywhere", position: .zero)
    }
    
    
    
//    func presentMenu() {
//        // Build the menu scene:
//        let menuScene = MenuScene()
//        
////        menuScene.size =
////        view!.bounds.size
//        
//        // Show the menu
////        self.view!.presentScene(menuScene)
//    }
    
    
    func updateTimer() {
        let now          = Date()
        let seconds      = now.since(startTime, in: .second)
        let minutes      = now.since(startTime, in: .minute)
        
        let sec2 = seconds - (minutes * 60)
        
        let timeText     = String(format: "Herding Time: %02d:%02d", minutes, sec2)
        timerLabel?.text = timeText
    }
    
    func updateTurdsRemainingLabel(turds: Int) {
        remainingLabel?.text = "Turds Remaining: \(turds)"
    }
    

    
    func addPlayAgainMessage(position: CGPoint = .zero) {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        let label: SKLabelNode
        label           = SKLabelNode(fontNamed: HUDSettings.font)
        label.text      = HUDMessages.playAgain
        label.name      = HUDMessages.playAgain
        label.zPosition = HUDSettings.messageZposition
        label.fontColor = UIColor.magenta
        label.fontSize  = HUDSettings.fontSize
        label.position  = position
        
        textureAtlas = SKTextureAtlas(named: "HUD")
        
        let playAgainButton = SKSpriteNode()
        
        // ----------------------
        // Build the start button
        let buttonWidth  = 750
        let buttonHeight = 275
        
        playAgainButton.texture = textureAtlas.textureNamed("green_button").copy() as? SKTexture
        playAgainButton.size = CGSize(width: buttonWidth, height: buttonHeight)
        
        // Name the start node for touch detection
        playAgainButton.name  = "PlayAgainButton"
//        playAgainButton.position = CGPoint(x: 0, y: 0)
        playAgainButton.position = position

        
        // Add text to the button
        let startText = SKLabelNode(fontNamed: HUDSettings.font)
        startText.text = "Play Again?"
        startText.verticalAlignmentMode = .center
        startText.fontColor = UIColor.red
        startText.position = CGPoint(x: 0, y: 2)
        startText.fontSize = 100
        
        // Name the text node for touch detection
        startText.name = "PlayAgainButton"
        startText.zPosition = 5
        playAgainButton.addChild(startText)
        
        // Pulse the start text in and out gently
        let pulseAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.5, duration: 0.9),
            SKAction.fadeAlpha(to: 1, duration: 0.9)
            ])
        startText.run(SKAction.repeatForever(pulseAction))
        // Build the start button
        // ----------------------
        

        
        
        
//        self.addChild(label)

        afterDelay(2.0) {
//            self.addChild(label)
            self.addChild(playAgainButton)
        }
        
        
//        addChild(label)
        
//        label.afterDelay(2.0) {
//            self.addChild(label)
//        }
        
//        let action = SKAction.afterDelay(2.0) {
//            self.add(message: HUDMessages.playAgain, position: CGPoint(x: scene.frame.midX, y: scene.frame.minY), fontSize: HUDSettings.fontSize, color: UIColor.magenta)
//        }
//
//
//        SKAction.run(action)
    }
    
    
    func addRemainingTurdsLabel() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        let position = CGPoint(x: scene.frame.midX, y: scene.frame.minY + 50)
        
        add(message: "RemainingTurdsLabel", position: position, fontSize: HUDSettings.fontSize, color: UIColor.yellow)
        
        remainingLabel = childNode(withName: "RemainingTurdsLabel") as? SKLabelNode
        updateTurdsRemainingLabel(turds: 0)
    }

    
    func addTimeTakenLabel() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        
        add(message: "TimeTaken", position: position, fontSize: 36)
        
        timeTakenLabel = childNode(withName: "TimeTaken") as? SKLabelNode
        timeTakenLabel?.verticalAlignmentMode = .bottom
        
        let minutes = Date().since(startTime, in: .minute)
        let seconds = Date().since(startTime, in: .second)
        
//        print("\nSeconds Taken: \(seconds)\n")
        
        let timeTaken             = Date().timeIntervalSince(startTime)
//        timeTakenLabel?.text      = "Time taken:  \(Int(timeTaken)) seconds"
        
        // High score text
        
        
        timeTakenLabel?.text      = String(format: "Turd Herding Time - %02d:%02d", minutes, seconds)
        
        timeTakenLabel?.fontColor = .yellow
    }
    
    
    func getTimeTakenText() -> String {
        let minutes = Date().since(startTime, in: .minute)
        let seconds = Date().since(startTime, in: .second)
        
        let sec2 = seconds - (minutes * 60)

        return String(format: "Turd Herding Time - %02d:%02d", minutes, sec2)
    }
    
    func addTimer(startTime: Date) {
        guard let scene = scene else { return }
        
        self.startTime = startTime
        let position = CGPoint(x: 0, y: scene.frame.size.height/2 - 40)
        
        add(message: "Timer", position: position, fontSize: 50, color: UIColor.yellow)
        
        timerLabel = childNode(withName: "Timer") as? SKLabelNode
        timerLabel?.verticalAlignmentMode = .top
        updateTimer()
    }
    
    
    func addHUDImage(name: String, position: CGPoint) {
//        print("\n\nAdding hudImage \(name) to the scene\n\n")
        
        let image      = SKSpriteNode(imageNamed: name)
        image.name     = name
        image.position = position
        
        let scale  = SKAction.scale(to: 0, duration: 2.5)
        
        addChild(image)
        
        hudImage = childNode(withName: name) as? SKSpriteNode
        
//        hudImage?.run(SKAction.sequence([unhide, scale.reversed()]))
        
        hudImage?.run(scale.reversed())
        
    }
    
    
    func add(message: String, position: CGPoint, fontSize: CGFloat = HUDSettings.fontSize, color: UIColor = HUDSettings.fontColor) {
        let label: SKLabelNode
        label           = SKLabelNode(fontNamed: HUDSettings.font)
        label.text      = message
        label.name      = message
        label.zPosition = HUDSettings.messageZposition
        label.fontColor = color
        label.fontSize  = fontSize
        label.position  = position
        
        addChild(label)
    }
    

    func makeMenuBackground(size: CGSize) -> SKSpriteNode {
        let menuBackground = SKSpriteNode(color: .clear, size: size)
        menuBackground.name = "MenuBackground"

        let border         = SKShapeNode(rectOf: size, cornerRadius: 8.0)
        border.name        = "MenuBorder"
        border.strokeColor = UIColor.black
        border.fillColor   = UIColor.brown
        border.alpha       = 0.35
        border.lineWidth   = 5.0
        
        menuBackground.addChild(border)

        let toiletNode = getNiceToilet()
        let tx         = -(border.frame.width  / 2)
        let ty         = border.frame.height / 2

        toiletNode.position = CGPoint(x: tx, y: ty)
        menuBackground.addChild(toiletNode)
        
        return menuBackground
    }

    
//    func addMessageBox(title: String, message1: String?, message2: String?, bottomMessage: String?, size: CGSize = CGSize(width: 1200, height: 500)) {
    func addMessageBox(title: String, message1: String?, message2: String?, size: CGSize = CGSize(width: 1200, height: 500)) {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // Create the background frame & images
        let menuBackground = makeMenuBackground(size: size)
        menuBackground.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        menuBackground.position    = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        
        // Create the title
        let menuTitle: SKLabelNode
        menuTitle           = SKLabelNode(fontNamed: HUDSettings.font)
        menuTitle.zPosition = HUDSettings.messageZposition
        menuTitle.fontColor = UIColor.yellow
        menuTitle.fontSize  = HUDSettings.messageTitleSize
        menuTitle.text      = title
        menuTitle.position  = CGPoint(x: menuBackground.frame.midX, y: menuBackground.frame.maxY - menuTitle.frame.height)
        menuBackground.addChild(menuTitle)
        
        // Create Message1 Text
        if let message1 = message1 {
            let messageLabel = SKLabelNode(fontNamed: HUDSettings.font)
            messageLabel.fontSize  = HUDSettings.messageFontSize
            messageLabel.zPosition = HUDSettings.messageZposition
            messageLabel.text      = message1
            messageLabel.fontColor = UIColor.yellow
            messageLabel.position  = CGPoint(x: menuBackground.frame.midX, y: menuBackground.frame.midY)
            menuBackground.addChild(messageLabel)
        }

        // Create Message2 Text
        if let message2 = message2 {
            let messageLabel = SKLabelNode(fontNamed: HUDSettings.font)
            messageLabel.fontSize = HUDSettings.messageFontSize
            messageLabel.zPosition = HUDSettings.messageZposition
            messageLabel.text = message2
            messageLabel.fontColor = UIColor.orange
            
            messageLabel.position  = CGPoint(x: menuBackground.frame.midX, y: menuBackground.frame.minY + messageLabel.frame.height)
            menuBackground.addChild(messageLabel)
        }


        
        addChild(menuBackground)
        
        addPlayAgainMessage(position: CGPoint(x: 0, y: menuBackground.frame.minY - 50))
        
    }

    
    func getNiceToilet() -> SKNode {
        
        // Pulse the start text in and out gently
        let fumesPulse = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.3, duration: 0.9),
            SKAction.fadeAlpha(to: 1, duration: 0.9)
            ])
        
        let rotateLeft         = SKAction.rotate(byAngle: CGFloat(7.0).degreesToRadians(), duration: 1.0)
        let rotateRight        = SKAction.rotate(byAngle: CGFloat(-7.0).degreesToRadians(), duration: 1.0)
        rotateLeft.timingMode  = .easeInEaseOut
        rotateRight.timingMode = .easeInEaseOut
        let backAndForth       = SKAction.sequence([rotateLeft, rotateRight])
        let grouped            = SKAction.group([backAndForth, fumesPulse])
        let fumeAction         = SKAction.repeatForever(grouped)
        
        let toilet = SKSpriteNode(imageNamed: "toilet_plain1")
        let fumes  = SKSpriteNode(imageNamed: "fumes1")
        
        toilet.position = CGPoint(x: 0, y: 0)
        fumes.position  = CGPoint(x: -30, y: 50)
        fumes.run(fumeAction)
        
        let theToilet = SKNode()
        theToilet.addChild(toilet)
        theToilet.addChild(fumes)
        
        theToilet.name = "niceToilet"
        return theToilet
    }
    
    
    func doCountdown() {
        
        guard let scene = scene else { return }
        
        
        let three = SKLabelNode(fontNamed: HUDSettings.font)
        three.text      = "3"
        three.fontSize  = 256.0
        three.fontColor = SKColor.white
        three.position  = .zero
        
        scene.addChild(three)
    }
    
    
}
