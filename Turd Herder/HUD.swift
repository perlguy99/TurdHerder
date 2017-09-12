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
}


enum HUDKeys {
    static let bestTime   = "BestTime"
    static let soundState = "SoundState"
    static let musicState = "MusicState"
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
    
    
    var gameSoundOn: Bool {
        get {
            return UserDefaults.standard.bool(forKey: HUDKeys.soundState)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: HUDKeys.soundState)
            UserDefaults.standard.synchronize()
        }
    }
    
    var gameMusicOn: Bool {
        get {
            print("Game Music On: \(UserDefaults.standard.bool(forKey: HUDKeys.musicState))")
            
            return UserDefaults.standard.bool(forKey: HUDKeys.musicState)
        }
        set {
            print("Setting Game Music On state to: \(gameMusicOn)")
            
            UserDefaults.standard.set(newValue, forKey: HUDKeys.musicState)
            UserDefaults.standard.synchronize()
        }
    }

    
    var bestTime: Int64 {
        get {
            return Int64(UserDefaults.standard.integer(forKey: HUDKeys.bestTime))
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
//            add(message: HUDMessages.tapToStart, position: .zero)

        case .playing:
            print("++ updateUI.playing")
            
        case .win:
            print("++ updateUI.win")
            
            remove(message: "Timer")
            remove(message: "RemainingTurdsLabel")
            remove(message: "MenuBackground")
            
//            let titleText = winningTitles[Int.random(winningTitles.count)]
            
//            addMessageBox(title: titleText, message1: getTimeTakenText(), message2: "Message 2")
            addGameOverScreen()
            
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
//            remove(message: HUDMessages.tapToStart)

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
        
        let playAgainButton = SKSpriteNode(imageNamed: "play_again")
        playAgainButton.zPosition = 1000
        playAgainButton.name = "playAgainButton"
        playAgainButton.setScale(0)
        playAgainButton.position = position
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

    
    func addTimeTakenLabel() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let position = CGPoint(x: scene.frame.midX, y: scene.frame.midY)
        
        add(message: "TimeTaken", position: position, fontSize: 36)
        
        timeTakenLabel = childNode(withName: "TimeTaken") as? SKLabelNode
        timeTakenLabel?.verticalAlignmentMode = .bottom
        
        let minutes = Date().since(startTime, in: .minute)
        let seconds = Date().since(startTime, in: .second)
        
        timeTakenLabel?.text      = String(format: "Turd Herding Time - %02d:%02d", minutes, seconds)
        
        timeTakenLabel?.fontColor = .yellow
    }
    

    func getTimeTakenImage() -> SKSpriteNode {
        let timeTakenImage = SKSpriteNode(imageNamed: "officialtime")
        timeTakenImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        let timeTakenSize = timeTakenImage.frame.size
        
        let minutes    = Date().since(startTime, in: .minute)
        let seconds    = Date().since(startTime, in: .second)
        let sec2       = seconds - (minutes * 60)
        let timeString = String(format: "%02d:%02d", minutes, sec2)
        var index      = CGFloat(0)

        for char in timeString.characters {
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
        let image      = SKSpriteNode(imageNamed: name)
        image.name     = name
        image.position = position
        
        let scale  = SKAction.scale(to: 0, duration: 2.5)
        
        addChild(image)
        
        hudImage = childNode(withName: name) as? SKSpriteNode
        
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
        let tx         = -((border.frame.width / 2) + 50)
        let ty         = border.frame.height / 2

        toiletNode.position = CGPoint(x: tx, y: ty)
        menuBackground.addChild(toiletNode)
        
        return menuBackground
    }

    
    func getScaleForWinningTitleImage(image: SKSpriteNode) -> CGFloat {
        
//        print("\n##############################################")
        image.setScale(1.0)
        
        let imageWidth = image.frame.size.width
//        print("Image Width: \(imageWidth.description)")
        
        // Added 100 for 50px padding on each side.
        let myscale = ((sceneWidth - 100) / imageWidth)
        
//        print("My Scale: \(myscale.description)")
        
        print(image.frame)
//        print("##############################################\n")

        return myscale
        
    }
    
    
    // Add the toilet
    // add another message
    // make the "play again" button twitch a bit.
    

    func addGameOverScreen() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

        let winningTitleImage = winningTitleImages[Int.random(winningTitleImages.count)]
        let imageScale        = getScaleForWinningTitleImage(image: winningTitleImage)
        
        winningTitleImage.name = "winningTitle"
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
        
        timeTakenImage.position = CGPoint(x: -ttiX, y: 0)
        timeTakenImage.zPosition = 1500
        scene.addChild(timeTakenImage)
    }
    
    
    // MARK: - Sounds
    func playBackgroundMusic(name: String) {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        if let backgroundMusic = childNode(withName: "backgroundMusic") {
            backgroundMusic.removeFromParent()
        }
        
        if gameMusicOn {
            let music = SKAudioNode(fileNamed: name)
            music.name = "backgroundMusic"
            music.autoplayLooped = true
            addChild(music)
        }
    }
    
    func stopBackgroundMusic() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        if let backgroundMusic = childNode(withName: "backgroundMusic") {
            backgroundMusic.removeFromParent()
        }
    }
    
    func addMenuButtons() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)

//        let buttonSoundOn  = SKSpriteNode(imageNamed: "sound_on_button")
//        let buttonSoundOff = SKSpriteNode(imageNamed: "sound_off_button")
//        let buttonMusicOn  = SKSpriteNode(imageNamed: "music_on_button")
//        let buttonMusicOff = SKSpriteNode(imageNamed: "music_off_button")
//        let buttonAbout    = SKSpriteNode(imageNamed: "about_button")

//        let buttonSoundOn  = SKSpriteNode(imageNamed: "sound_on_0x01")
//        let buttonSoundOff = SKSpriteNode(imageNamed: "sound_off_0x01")
//        let buttonMusicOn  = SKSpriteNode(imageNamed: "music_on_0x01")
//        let buttonMusicOff = SKSpriteNode(imageNamed: "music_off_0x01")
//        let buttonAbout    = SKSpriteNode(imageNamed: "about_0x01")

//        let buttonSoundOn  = SKSpriteNode(imageNamed: "sound_on_0x02")
//        let buttonSoundOff = SKSpriteNode(imageNamed: "sound_off_0x02")
//        let buttonMusicOn  = SKSpriteNode(imageNamed: "music_on_0x02")
//        let buttonMusicOff = SKSpriteNode(imageNamed: "music_off_0x02")
//
//        let buttonAbout    = SKSpriteNode(imageNamed: "about_0x05")

        let buttonSoundOn  = SKSpriteNode(imageNamed: "sound_on_f1")
        let buttonSoundOff = SKSpriteNode(imageNamed: "sound_off_f1")
        let buttonMusicOn  = SKSpriteNode(imageNamed: "music_on_f1")
        let buttonMusicOff = SKSpriteNode(imageNamed: "music_off_f1")
        let buttonAbout    = SKSpriteNode(imageNamed: "about_f1")

        buttonSoundOn.setScale(0.25)
        buttonSoundOff.setScale(0.25)
        buttonMusicOn.setScale(0.25)
        buttonMusicOff.setScale(0.25)
        buttonAbout.setScale(0.25)
        
        buttonSoundOn.name  = HUDButtons.soundOn
        buttonSoundOff.name = HUDButtons.soundOff
        buttonMusicOn.name  = HUDButtons.musicOn
        buttonMusicOff.name = HUDButtons.musicOff
        buttonAbout.name    = HUDButtons.about
        
        buttonSoundOn.isHidden  = !gameSoundOn
        buttonSoundOff.isHidden = gameSoundOn
        buttonSoundOn.position  = CGPoint(x: -600, y: 100)
        buttonSoundOff.position = CGPoint(x: -600, y: 100)
        
        buttonMusicOn.isHidden  = !gameMusicOn
        buttonMusicOff.isHidden = gameMusicOn
        buttonMusicOn.position  = CGPoint(x: -600, y: -100)
        buttonMusicOff.position = CGPoint(x: -600, y: -100)
        
        buttonAbout.position    = CGPoint(x: -600, y: -300)
        
        scene.addChild(buttonSoundOn)
        scene.addChild(buttonSoundOff)
        scene.addChild(buttonMusicOn)
        scene.addChild(buttonMusicOff)
        scene.addChild(buttonAbout)
    }

    
    func addHomeButton() {
        guard let scene = scene else { return }
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let buttonBack    = SKSpriteNode(imageNamed: "back_f1")
        buttonBack.setScale(0.25)
        buttonBack.name    = HUDButtons.about
        
        buttonBack.position    = CGPoint(x: -600, y: -300)
        
        scene.addChild(buttonBack)
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
        fumes.zPosition = 500
        fumes.run(fumeAction)
        
        let theToilet = SKNode()
        theToilet.addChild(toilet)
        theToilet.addChild(fumes)
        
        theToilet.name = "niceToilet"
        return theToilet
    }
    
    
    func doCountdown() {
        guard let scene = scene else { return }
        
        let three = SKSpriteNode(imageNamed: "3").copy() as? SKSpriteNode
        let two   = SKSpriteNode(imageNamed: "2").copy() as? SKSpriteNode
        let one   = SKSpriteNode(imageNamed: "1").copy() as? SKSpriteNode

        three?.isHidden = true
        two?.isHidden = true
        one?.isHidden = true
        
        three?.setScale(5.0)
        two?.setScale(5.0)
        one?.setScale(5.0)

        scene.addChild(three!)
        scene.addChild(two!)
        scene.addChild(one!)
        
        let scaleOut = SKAction.scale(to: 0, duration: 1)

        let toot = SKAction.playSoundFileNamed("fart29.wav", waitForCompletion: false)
        
        let actionUnhide = SKAction.unhide()
        scaleOut.timingMode = .easeInEaseOut
        
        print("\ndoCountdown()\n")
        
        three!.run(SKAction.sequence([actionUnhide, toot, scaleOut, SKAction.removeFromParent()]))
        two!.run(SKAction.sequence([SKAction.wait(forDuration: 1), actionUnhide, toot, scaleOut, SKAction.removeFromParent()]))
        one!.run(SKAction.sequence([SKAction.wait(forDuration: 2), actionUnhide, toot, scaleOut, SKAction.removeFromParent()]))
    }
    
    
}
