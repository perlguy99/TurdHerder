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

enum HUDButtons {
    static let soundOn  = "ButtonSoundOn"
    static let soundOff = "ButtonSoundOff"
    static let musicOn  = "ButtonMusicOn"
    static let musicOff = "ButtonMusicOff"
    static let about    = "ButtonAbout"
    static let nuke     = "ButtonNuke"
    static let back     = "ButtonBack"
}

enum HUDKeys {
    static let bestTime   = "BestTime"
    static let soundState = "SoundState"
    static let musicState = "MusicState"
}

enum HUDSettings {
    static let font                      = "Freckle Face"
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
    var timeTakenLabel: SKLabelNode?
    var textureAtlas: SKTextureAtlas!
    var hudImage: SKSpriteNode?
    var bestTimeFlag: Bool?
    
    let counterFart = SKAction.playSoundFileNamed("AirBiscuit.mp3", waitForCompletion: false)
    
    var gameTimer      = Timer()
    var isTimerRunning = false
    var gameTime : Int = 0
    
    var bestTime: Int {
        get {
            return UserDefaults.standard.integer(forKey: HUDKeys.bestTime)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: HUDKeys.bestTime)
            UserDefaults.standard.synchronize()
        }
    }
    
    let winningTitles = [
        "Great Job Turd Herder!",
        "Well Done Turd Herder!",
        "Awesome Turd Herding!",
        "Way To Round Them Up!",
        "A True Turd Herding Master",
        "You're a Master Turd Herder!",
        "You Earned Your Brown Belt!",
    ]
    
    let winningMessages = [
        "You must have been practicing your turd herding skills!",
        "Whoa, you really ripped one that time!",
        "Never kick a fresh turd on a hot day",
        "This wasn't your first turd herding rodeo",
        "♪♪♪ It's boots & craps & cowboy hats ♪♪♪",
        "Never squat with your spurs on turd herder",
        "If pooping is the call of nature, does that mean farting is a missed call?",
        "Do clown farts smell funny?"
    ]
    
    let winningTitleImages = [
        SKSpriteNode(imageNamed: "winning_title_01"),
        SKSpriteNode(imageNamed: "winning_title_02"),
        SKSpriteNode(imageNamed: "winning_title_03"),
        SKSpriteNode(imageNamed: "winning_title_04"),
        SKSpriteNode(imageNamed: "winning_title_05"),
        SKSpriteNode(imageNamed: "winning_title_06"),
        SKSpriteNode(imageNamed: "winning_title_07"),
        SKSpriteNode(imageNamed: "winning_title_08"),
        SKSpriteNode(imageNamed: "winning_title_09"),
        SKSpriteNode(imageNamed: "winning_title_10"),
        SKSpriteNode(imageNamed: "winning_title_11"),
        SKSpriteNode(imageNamed: "winning_title_12"),
        SKSpriteNode(imageNamed: "winning_title_13"),
        SKSpriteNode(imageNamed: "winning_title_14"),
        SKSpriteNode(imageNamed: "winning_title_15"),
        SKSpriteNode(imageNamed: "winning_title_15"),
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
        
        if bestTime == 0 {
            bestTime = gameTime
            bestTimeFlag = true
        }
        
        if gameTime < bestTime {
            bestTime = gameTime
            bestTimeFlag = true
        }
    }
    
    
    private func updateUI(gameState: GameState) {
        // Uses the "TO" GameState value
        // add messages for the new state
        switch gameState {
        case .initial: break
            
        case .start:
            gameTime = 0
            bestTimeFlag = false

        case .playing:
            startTimer()
            
        case .win:
  
            winEvents()
//            remove(message: "Timer")
//            remove(message: "RemainingTurdsLabel")
//            remove(message: "MenuBackground")
//            remove(message: HUDButtons.back)
//            remove(message: HUDButtons.nuke)
//
//            stopTimer()
//            addGameOverScreen()
//            checkForBestTime()
//
//            if bestTimeFlag == true {
//                addHighScoreImage()
//            }
            
        case .restart: break
//            print("++ updateUI.restart")

        case .pause:
            pauseTimer()
            
        }
    }
    
    
    func winEvents() {
        remove(message: "Timer")
        remove(message: "RemainingTurdsLabel")
        remove(message: "MenuBackground")
        remove(message: HUDButtons.back)
        remove(message: HUDButtons.nuke)
        
        stopTimer()
        addGameOverScreen()
        checkForBestTime()
        
        if bestTimeFlag == true {
            addHighScoreImage()
        }

    }
    
    
    private func clearUI(gameState: GameState) {
        // Uses the "FROM" GameState value
        // clear previous state messages
        switch gameState {
            
        case .initial: break
//            print("-- clearUI.initial")

        case .start: break
//            print("-- clearUI.start")

        case .playing: break
//            print("-- clearUI.playing")
            
        case .win:
//            print("-- clearUI.win")
            remove(message: HUDMessages.win)
            
        case .restart: break
//            print("-- clearUI.restart")
            
        case .pause: break
//            print("-- clearUI.pause")
            
        }
        
    }
    
    
    private func remove(message: String) {
        scene?.childNode(withName: message)?.removeFromParent()
        childNode(withName: message)?.removeFromParent()
    }
    
    
    func startTimer() {
        if isTimerRunning == false {
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateGameTimer)), userInfo: nil, repeats: true)
        }
        
        isTimerRunning = true
    }
    
    func pauseTimer() {
        gameTimer.invalidate()
        isTimerRunning = false
    }
    
    func stopTimer() {
        gameTimer.invalidate()
        isTimerRunning = false

    }
    
    @objc func updateGameTimer() {
        gameTime += 1
    }
    
    
    func updateTimer() {
        let newSeconds = gameTime % 60
        let newMinutes = gameTime / 60
        
        let timeText     = String(format: "Herding Time: %02d:%02d", newMinutes, newSeconds)
        timerLabel?.text = timeText
    }
    
    
    func updateTurdsRemainingLabel(turds: Int) {
        remainingLabel?.text = "Turds Remaining: \(turds)"
    }
    
    
    func addPlayAgainMessage(position: CGPoint = .zero) {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let playAgainButton = SKSpriteNode(imageNamed: "play_again")
        playAgainButton.zPosition = 1000
        playAgainButton.name      = "playAgainButton"
        playAgainButton.position  = position
        playAgainButton.setScale(0)

        self.addChild(playAgainButton)
        
        // Pulse the start text in and out gently
        let pulseAction = SKAction.sequence([
            SKAction.fadeAlpha(to: 0.6, duration: 0.5),
            SKAction.fadeAlpha(to: 1, duration: 0.9)
            ])
        playAgainButton.run(SKAction.repeatForever(pulseAction))
        
        let scaleReplayUp   = SKAction.scale(to: 1.75, duration: 1.0)
        let scaleReplayDown = SKAction.scale(to: 1.50, duration: 0.5)
        
        playAgainButton.run(SKAction.afterDelay(2.0, performAction: SKAction.sequence([scaleReplayUp, scaleReplayDown])))
    }
    
    
    func addRemainingTurdsLabel() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        let position = CGPoint(x: scene.frame.midX, y: scene.frame.minY + 50)
        
        add(message: "RemainingTurdsLabel", position: position, fontSize: HUDSettings.fontSize, color: UIColor.yellow)
        
        remainingLabel = childNode(withName: "RemainingTurdsLabel") as? SKLabelNode
        updateTurdsRemainingLabel(turds: 0)
    }


    func getTimeTakenImage() -> SKSpriteNode {
        let timeTakenImage = SKSpriteNode(imageNamed: "officialtime")
        timeTakenImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        let timeTakenSize = timeTakenImage.frame.size
        
        let newSeconds = gameTime % 60
        let newMinutes = gameTime / 60

        let timeString = String(format: "%02d:%02d", newMinutes, newSeconds)
        var index      = CGFloat(0)

        for char in timeString {
            if let theImage = getImageForCharacter(character: char) {
                let xPos = 50 + ((timeTakenSize.width/2) + (CGFloat(CGFloat(50.0) * index)))
                
                timeTakenImage.addChild(theImage)
                theImage.position = CGPoint(x: xPos, y: 0)
                index += 1
            }
        }
        return timeTakenImage
    }
    
    
    func getImageForCharacter(character: Character) -> SKSpriteNode? {
        
        if character == "0" {
            return SKSpriteNode(imageNamed: "0").copy() as? SKSpriteNode
        }
        if character == "1" {
            return SKSpriteNode(imageNamed: "1").copy() as? SKSpriteNode
        }
        if character == "2" {
            return SKSpriteNode(imageNamed: "2").copy() as? SKSpriteNode
        }
        if character == "3" {
            return SKSpriteNode(imageNamed: "3").copy() as? SKSpriteNode
        }
        if character == "4" {
            return SKSpriteNode(imageNamed: "4").copy() as? SKSpriteNode
        }
        if character == "5" {
            return SKSpriteNode(imageNamed: "5").copy() as? SKSpriteNode
        }
        if character == "6" {
            return SKSpriteNode(imageNamed: "6").copy() as? SKSpriteNode
        }
        if character == "7" {
            return SKSpriteNode(imageNamed: "7").copy() as? SKSpriteNode
        }
        if character == "8" {
            return SKSpriteNode(imageNamed: "8").copy() as? SKSpriteNode
        }
        if character == "9" {
            return SKSpriteNode(imageNamed: "9").copy() as? SKSpriteNode
        }
        if character == ":" {
            return SKSpriteNode(imageNamed: "colon").copy() as? SKSpriteNode
        }
        
        return nil
    }
    

    func addTimer() {
        guard let scene = scene else { return }
        
        let position = CGPoint(x: 0, y: scene.frame.size.height/2 - 40)
        
        add(message: "Timer", position: position, fontSize: 50, color: UIColor.yellow)
        
        timerLabel = childNode(withName: "Timer") as? SKLabelNode
        timerLabel?.verticalAlignmentMode = .top
        updateTimer()
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
    

    func getScaleForWinningTitleImage(image: SKSpriteNode) -> CGFloat {
        image.setScale(1.0)
        
        let imageWidth = image.frame.size.width

        // Added 100 for 50px padding on each side.
        let myscale = ((sceneWidth - 100) / imageWidth)
        
        print(image.frame)
        return myscale
    }

    
    func addGameOverScreen() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        let winningTitleImage = winningTitleImages[Int.random(winningTitleImages.count)]
        let imageScale        = getScaleForWinningTitleImage(image: winningTitleImage)
        
        winningTitleImage.name      = "winningTitle"
        winningTitleImage.zPosition = 1000
        winningTitleImage.setScale(imageScale)
        
        let finalHeight = winningTitleImage.frame.size.height
        let yPos = ((sceneHeight - 100) / 2) - finalHeight
        
        winningTitleImage.position = CGPoint(x: 0, y: yPos)
        
        scene.addChild(winningTitleImage)
        
        let yPlayAgain = ((sceneHeight - 100) / 2) - 150
        addPlayAgainMessage(position: CGPoint(x: 0, y: -yPlayAgain))
        
        let timeTakenImage = getTimeTakenImage()
        let ttiX           = ((timeTakenImage.calculateAccumulatedFrame().width - timeTakenImage.frame.width) / 2)
        
        timeTakenImage.position  = CGPoint(x: -ttiX, y: 0)
        timeTakenImage.zPosition = 1500
        scene.addChild(timeTakenImage)
    }
    
    
    func addHighScoreImage() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        guard let highScoreStars = SKEmitterNode(fileNamed: "HighScore") else { return }
        
        let bestTimeTurd  = SKSpriteNode(imageNamed: "best_time_turd")
        bestTimeTurd.name = "BestTimeTurd"
        
        highScoreStars.zPosition = -1
        highScoreStars.position  = bestTimeTurd.position
        bestTimeTurd.addChild(highScoreStars)
        
        let bestTimeLabel = SKSpriteNode(imageNamed : "new_best_time")
        let btY           = bestTimeTurd.frame.minY
        print(btY)
        bestTimeLabel.position = CGPoint(x: 0, y: btY - 20)
        
        bestTimeTurd.addChild(bestTimeLabel)
        bestTimeTurd.position = CGPoint(x: 0, y: -250)
        
        bestTimeTurd.setScale(0)
        scene.addChild(bestTimeTurd)
        
        let scaleReplayUp   = SKAction.scale(to: 1.5, duration: 0.5)
        let scaleReplayDown = SKAction.scale(to: 1, duration: 0.5)
        
        bestTimeTurd.run(SKAction.afterDelay(1.0, performAction: SKAction.sequence([scaleReplayUp, scaleReplayDown])))
    }
    
    
    // MARK: - Sounds
    func playBackgroundMusic(name: String) {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        if let backgroundMusic = scene.childNode(withName: "backgroundMusic") {
            backgroundMusic.removeFromParent()
        }
        
        if gameMusicOn {
            let music = SKAudioNode(fileNamed: name)
            music.name           = "backgroundMusic"
            music.autoplayLooped = true
            scene.addChild(music)
        }
    }
    
    func stopBackgroundMusic() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        if let backgroundMusic = scene.childNode(withName: "backgroundMusic") {
            backgroundMusic.removeFromParent()
        }
    }
    
    func addMenuButtons() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        let buttonSoundOn  = SKSpriteNode(imageNamed: "sound_on_f1")
        let buttonSoundOff = SKSpriteNode(imageNamed: "sound_off_f1")
        let buttonMusicOn  = SKSpriteNode(imageNamed: "music_on_f1")
        let buttonMusicOff = SKSpriteNode(imageNamed: "music_off_f1")
        let buttonAbout    = SKSpriteNode(imageNamed: "about_f1")

        buttonSoundOn.name  = HUDButtons.soundOn
        buttonSoundOff.name = HUDButtons.soundOff
        buttonMusicOn.name  = HUDButtons.musicOn
        buttonMusicOff.name = HUDButtons.musicOff
        buttonAbout.name    = HUDButtons.about
        
        buttonSoundOn.isHidden  = !gameSoundOn
        buttonSoundOff.isHidden = gameSoundOn
        buttonMusicOn.isHidden  = !gameMusicOn
        buttonMusicOff.isHidden = gameMusicOn
        
        let bbX = scene.frame.minX + 100
        let bbY = scene.frame.minY + 100
        
        buttonSoundOn.position  = CGPoint(x: bbX, y: bbY + 400)
        buttonSoundOff.position = CGPoint(x: bbX, y: bbY + 400)
        buttonMusicOn.position  = CGPoint(x: bbX, y: bbY + 200)
        buttonMusicOff.position = CGPoint(x: bbX, y: bbY + 200)
        buttonAbout.position    = CGPoint(x: bbX, y: bbY)
        
        scene.addChild(buttonSoundOn)
        scene.addChild(buttonSoundOff)
        scene.addChild(buttonMusicOn)
        scene.addChild(buttonMusicOff)
        scene.addChild(buttonAbout)
    }

    
    func addMenuButton() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let buttonBack    = SKSpriteNode(imageNamed: "back")
        buttonBack.setScale(0.25)
        buttonBack.name    = HUDButtons.back
        
        buttonBack.position = CGPoint(x: -600, y: -300)
        
        scene.addChild(buttonBack)
    }
    
    
    func addBackButton() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let buttonBack  = SKSpriteNode(imageNamed: "back")
        buttonBack.name = HUDButtons.back
        
        let bbX = scene.frame.minX + 100
        let bbY = scene.frame.minY + 100

        buttonBack.position = CGPoint(x: bbX, y: bbY)
        
        scene.addChild(buttonBack)
    }

    
    func addNukeButton() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let buttonNuke  = SKSpriteNode(imageNamed: "nuke")
        buttonNuke.name = HUDButtons.nuke
        
        let bbX = scene.frame.minX + 100
        let bbY = scene.frame.minY + 100
        
        buttonNuke.position = CGPoint(x: bbX, y: bbY)
        
        scene.addChild(buttonNuke)
    }
    
    
    func getNiceToilet() -> SKNode {
        print("getNiceToilet()")
        
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
        fumes.zPosition = 500
        fumes.run(fumeAction)
        
        let theToilet = SKNode()
        theToilet.addChild(toilet)
        theToilet.addChild(fumes)
        
        theToilet.name = "niceToilet"
        return theToilet
    }
   
    
}
