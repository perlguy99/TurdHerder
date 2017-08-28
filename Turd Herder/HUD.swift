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
    static let yourTime   = "Your Time: "
    static let playAgain  = "Tap to Play Again"
    static let three      = "3"
    static let two        = "2"
    static let one        = "1"
    static let go         = "Go"
    
}


enum HUDSettings {
    static let font               = "turds"
//    static let font               = "<PAPER FOR YOUR ASS>"
    static let fontColor: UIColor = UIColor.brown
    static let fontSize: CGFloat  = 30
    static let titleSize: CGFloat = 50
}



class HUD: SKNode {
    
    var remainingLabel: SKLabelNode?
    var timerLabel: SKLabelNode?
    var startTime: Date!
    var timeTakenLabel: SKLabelNode?
    
    var hudImage: SKSpriteNode?
    
    let counterFart = SKAction.playSoundFileNamed("AirBiscuit.mp3", waitForCompletion: false)
    
    override init() {
        super.init()
        name = "HUD"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addRemainingInfo(position: CGPoint, fontSize: CGFloat = HUDSettings.fontSize) {
        let label: SKLabelNode
        label = SKLabelNode(fontNamed: HUDSettings.font)
        label.name = "remainingInfo"
        
        addChild(label)
        label.fontSize = fontSize
        label.fontColor = HUDSettings.fontColor
        label.color = HUDSettings.fontColor
        label.position = position
        
    }
    
    
    func updateGameState(from: GameState, to: GameState) {
        clearUI(gameState: from)
        updateUI(gameState: to)
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
            addTimeTakenLabel()
            remove(message: "Timer")
            remove(message: "RemainingTurdsLabel")
            
            
//            addMessageBox(title: "My Menu Test", size: CGSize(width: 600, height: 350))
            addMessageBox(title: "New Menu Test", message1: "Message 1", message2: "Message 2", bottomMessage: "Bottom Message")
            
//            perform(#selector(changeHUDImage), with: nil, afterDelay: 3)
            
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
    
    
    
    func presentMenu() {
        // Build the menu scene:
        let menuScene = MenuScene()
        
//        menuScene.size =
//        view!.bounds.size
        
        // Show the menu
//        self.view!.presentScene(menuScene)
    }
    
    
    func updateTimer() {
        let now          = Date()
        let seconds      = now.since(startTime, in: .second)
        let minutes      = now.since(startTime, in: .minute)
        let timeText     = String(format: "%02d:%02d", minutes, seconds)
        timerLabel?.text = timeText
    }
    
    func updateTurdsRemainingLabel(turds: Int) {
        remainingLabel?.text = "Turds Remaining: \(turds)"
    }
    

    func addRemainingTurdsLabel() {
        guard let scene = scene else { return }
        
        let position = CGPoint(x: 0, y: scene.frame.midY - 50)
        add(message: "RemainingTurdsLabel", position: position, fontSize: HUDSettings.fontSize)
        
        remainingLabel = childNode(withName: "RemainingTurdsLabel") as? SKLabelNode
        updateTurdsRemainingLabel(turds: 0)
    }

    
    func addTimeTakenLabel() {
        guard let scene = scene else { return }
        
        let position = CGPoint(x: 0, y: scene.frame.midY - 175)
        
        add(message: "TimeTaken", position: position, fontSize: 36)
        
        timeTakenLabel = childNode(withName: "TimeTaken") as? SKLabelNode
        timeTakenLabel?.verticalAlignmentMode = .bottom
        
        
        let minutes = Date().since(startTime, in: .minute)
        let seconds = Date().since(startTime, in: .second)
        
        let timeTaken             = Date().timeIntervalSince(startTime)
//        timeTakenLabel?.text      = "Time taken:  \(Int(timeTaken)) seconds"
        
        timeTakenLabel?.text      = String(format: "Turd Herding Time - %02d:%02d", minutes, seconds)
        
        timeTakenLabel?.fontColor = .yellow
    }
    
    
    func addTimer(startTime: Date) {
        guard let scene = scene else { return }
        
        self.startTime = startTime
        let position = CGPoint(x: 0, y: scene.frame.size.height/2 - 20)
        
        add(message: "Timer", position: position, fontSize: 24)
        
        timerLabel = childNode(withName: "Timer") as? SKLabelNode
        timerLabel?.verticalAlignmentMode = .top
        updateTimer()
    }
    
    
    func addHUDImage(name: String, position: CGPoint) {
        print("\n\nAdding hudImage \(name) to the scene\n\n")
        
        let image      = SKSpriteNode(imageNamed: name)
        image.name     = name
        image.position = position
        
        let scale  = SKAction.scale(to: 0, duration: 2.5)
        
        addChild(image)
        
        hudImage = childNode(withName: name) as? SKSpriteNode
        
//        hudImage?.run(SKAction.sequence([unhide, scale.reversed()]))
        
        hudImage?.run(scale.reversed())
        
    }
    
    
    func add(message: String, position: CGPoint, fontSize: CGFloat = HUDSettings.fontSize) {
        print("\n\nAdding \(message) to the scene\n\n")
        
        let label: SKLabelNode
        label           = SKLabelNode(fontNamed: HUDSettings.font)
        label.text      = message
        label.name      = message
        label.zPosition = 100
        
        addChild(label)
        
        label.fontColor = HUDSettings.fontColor
        label.fontSize = fontSize
        label.position = position
    }
    
    
    func makeMenuBackground(size: CGSize) -> SKSpriteNode {
        print("\n\nMake Menu Background\n\n")
        
        let menuBackground = SKSpriteNode()
        
//        menuBackground.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        
        var toiletNode: SKSpriteNode!
        
//        self.addChild(toiletNode)
        
        
//        let border = SKShapeNode(rectOf: CGSize(width: 600, height: 350) , cornerRadius: 8.0)
        let border = SKShapeNode(rectOf: size, cornerRadius: 8.0)
        border.strokeColor = UIColor.black
        border.fillColor = UIColor.brown
        border.alpha = 0.35
        border.lineWidth = 5.0
        menuBackground.addChild(border)

        
        
        if let theToiletScene = SKScene(fileNamed: "Toilet2") {
            toiletNode = theToiletScene.childNode(withName: "MyToilet") as! SKSpriteNode
            toiletNode.removeFromParent()
        }
        
        let originalToiletSize = CGSize(width: 537, height: 454)
        let newToiletSize      = CGSize(width: 207, height: 175)
        
        //        toiletNode.position = CGPoint(x: -175, y: 75)
        toiletNode.scale(to: newToiletSize)
        
        let bw = border.frame.width
        let tw = toiletNode.frame.width
        print("\n\nBW: \(bw) -- TW: \(tw)\n\n")
        
        let tx = -(border.frame.width  / 2)
        let ty = border.frame.height / 2

        
        // D5X: -303.350006103516  D5Y: 178.350006103516
        toiletNode.position = CGPoint(x: tx, y: ty)
        
        
        menuBackground.addChild(toiletNode)

        
        
        // DOT 1
        // X: 0, Y: 0
        let dot1 = SKShapeNode(circleOfRadius: 5)
        dot1.fillColor = UIColor.magenta
        dot1.position = CGPoint(x: 0, y: 0)
        dot1.zPosition = 500
        menuBackground.addChild(dot1)
        
        // DOT 2
        // D2X: 303.350006103516  D2Y: 178.350006103516
        let dot2 = SKShapeNode(circleOfRadius: 5)
        dot2.fillColor = UIColor.cyan
        let d2x = border.frame.width  / 2 // 303
        let d2y = border.frame.height / 2 // 178
        print("\n\nD2X: \(d2x)  D2Y: \(d2y)\n\n")
        dot2.position = CGPoint(x: d2x, y: d2y)
        dot2.zPosition = 500
        menuBackground.addChild(dot2)
        
        // DOT 3
        // D3X: -303.350006103516  D3Y: -178.350006103516
        let dot3 = SKShapeNode(circleOfRadius: 5)
        dot3.fillColor = UIColor.blue
        let d3x = -(border.frame.width  / 2)
        let d3y = -(border.frame.height / 2)
        print("\n\nD3X: \(d3x)  D3Y: \(d3y)\n\n")
        dot3.position = CGPoint(x: d3x, y: d3y)
        dot3.zPosition = 500
        menuBackground.addChild(dot3)
        
        // DOT 4
        // D4X: 303.350006103516  D4Y: -178.350006103516
        let dot4 = SKShapeNode(circleOfRadius: 5)
        dot4.fillColor = UIColor.red
        let d4x = border.frame.width  / 2
        let d4y = -(border.frame.height / 2)
        print("\n\nD4X: \(d4x)  D4Y: \(d4y)\n\n")
        dot4.position = CGPoint(x: d4x, y: d4y)
        dot4.zPosition = 500
        menuBackground.addChild(dot4)
        
        // DOT 5
        // D5X: -303.350006103516  D5Y: 178.350006103516
        let dot5 = SKShapeNode(circleOfRadius: 5)
        dot5.fillColor = UIColor.yellow
        let d5x = -(border.frame.width  / 2)
        let d5y = border.frame.height / 2
        print("\n\nD5X: \(d5x)  D5Y: \(d5y)\n\n")
        dot5.position = CGPoint(x: d5x, y: d5y)
        dot5.zPosition = 500
        menuBackground.addChild(dot5)
        
        
        
        

        return menuBackground
        
        
    }

    
    
//    func addMessageBox(message: String, position: CGPoint, fontSize: CGFloat = HUDSettings.fontSize) {
    func addMessageBox(title: String, message1: String?, message2: String?, bottomMessage: String?, size: CGSize = CGSize(width: 600, height: 350)) {
        print("\n\nAdding Message Box \(title) to the scene. SIZE: \(size)\n\n")
        
        let menuBackground = makeMenuBackground(size: size)
        addChild(menuBackground)
        
        let menuTitle: SKLabelNode
        menuTitle = SKLabelNode(fontNamed: HUDSettings.font)
        menuTitle.text = title
        menuTitle.zPosition = 100
        menuTitle.fontColor = HUDSettings.fontColor
        menuTitle.fontSize = HUDSettings.titleSize
        
        let menuXpos = menuTitle.frame.width
        let menuYpos = menuTitle.frame.height

        
        
//        let foo = (menuBackground.calculateAccumulatedFrame().height / 2) - menuTitle.frame.height - 10
        
        let foo = (size.height / 2) - menuTitle.frame.height - 10

        menuTitle.position = CGPoint(x: 0, y: foo)
        
        print("\n\nW: \(menuTitle.frame.width) -- H: \(menuTitle.frame.height) - FOO: \(foo)\n\n")
        
        addChild(menuTitle)
        

        if let message1 = message1 {
            let messageLabel = SKLabelNode(fontNamed: HUDSettings.font)
            messageLabel.fontSize = 30
            messageLabel.zPosition = 100
            messageLabel.text = message1
            messageLabel.fontColor = UIColor.green
            
            messageLabel.position = .zero
            addChild(messageLabel)
        }

        
        if let message2 = message2 {
            let messageLabel = SKLabelNode(fontNamed: HUDSettings.font)
            messageLabel.fontSize = 30
            messageLabel.zPosition = 100
            messageLabel.text = message2
            messageLabel.fontColor = UIColor.orange
            
            let y = messageLabel.frame.height
            
            print("\n\nY: \(y)\n\n")
            
            messageLabel.position = CGPoint(x: 0, y: -y)
            addChild(messageLabel)
        }

        
        if let bottomMessage = bottomMessage {
            let messageLabel = SKLabelNode(fontNamed: HUDSettings.font)
            messageLabel.fontSize = 30
            messageLabel.zPosition = 100
            messageLabel.text = bottomMessage
            messageLabel.fontColor = UIColor.red
            
//            let foo = -((menuBackground.calculateAccumulatedFrame().height / 2) - (menuTitle.frame.height / 2))
            let foo = -((size.height / 2) - (menuTitle.frame.height / 2))
            
            print("\n\nFOO: \(foo)\n\n")
            
            messageLabel.position = CGPoint(x: 0, y: foo)
            addChild(messageLabel)
        }


        
        
//        let label: SKLabelNode
//        label           = SKLabelNode(fontNamed: HUDSettings.font)
//        label.text      = message
//        label.name      = message
//        label.zPosition = 100
//
//        addChild(label)
//
//        label.fontColor = HUDSettings.fontColor
//        label.fontSize = fontSize
//        label.position = position
//
        
    }

    
    
    
//    guard let scene = scene else { return }
//
//    let position = CGPoint(x: 0, y: scene.frame.midY - 50)
//    add(message: "RemainingTurdsLabel", position: position, fontSize: HUDSettings.fontSize)
//
//    remainingLabel = childNode(withName: "RemainingTurdsLabel") as? SKLabelNode
//    updateTurdsRemainingLabel(turds: 0)
    
//    addHUDImage(name: "gameOver", position: .zero)
    
    
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
