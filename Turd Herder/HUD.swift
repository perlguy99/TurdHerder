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
    static let font              = "KenVector Future"
    static let fontSize: CGFloat = 30
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
            
            addHUDImage(name: "gameOver", position: .zero)
            addTimeTakenLabel()
            remove(message: "Timer")
            remove(message: "RemainingTurdsLabel")
            
            perform(#selector(changeHUDImage), with: nil, afterDelay: 3)
            
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
        
        label.fontSize = fontSize
        label.position = position
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
