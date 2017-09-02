////
////  Scene.swift
////  Turd Herder
////
////  Created by Brent Michalski on 7/6/17.
////  Copyright © 2017 Brent Michalski. All rights reserved.
////
//
//// TODO: Tap anywhere to play again
//// TODO: Sound effects
//// TODO: Background music
//// TODO: Message to hold device in proper orientation?
//// TODO: Add haptic feedback every time a new turd is created?
//// TODO: Determine game states
//
//
//import SpriteKit
//import ARKit
//import GameplayKit
//
////protocol EventListenerNode {
////    func didMoveToScene()
////}
//
//
//class Scene: SKScene {
//    var targetCreationRate:TimeInterval = 0.25
//
//    let maxTargets       = 1
//    var currentFartIndex = 0
//
//    var hud = HUD()
//
//    var toiletNode: ToiletNode!
//
//    var startTime: Date!
//    var timer: Timer?
//    var targetsCreated = 0
//    var targetCount = 0 {
//        didSet {
//            hud.updateTurdsRemainingLabel(turds: targetCount)
//        }
//    }
//
//    var gameState: GameState = .initial {
//        didSet {
//            if oldValue != gameState {
//                hud.updateGameState(from: oldValue, to: gameState)
//
//                if gameState == .win {
//                    gameOver()
//                }
//            }
//        }
//    }
//
//
//    // Sound effects
//
//    let shortFarts = [
//        SKAction.playSoundFileNamed("fart2.mp3", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart3.mp3", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart4.mp3", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart5.mp3", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart6.mp3", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart7.mp3", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart8.mp3", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart9.mp3", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart10.mp3", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart11.mp3", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart12.mp3", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart13.mp3", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart14.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart16.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart17.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart18.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart20.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart21.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart23.mp3", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart24.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart25.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart26.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart27.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart28.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart34.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart36.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart38.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart39.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart40.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart41.wav", waitForCompletion: false),
//    ]
//
//    let targetCreationFarts = [
//        SKAction.playSoundFileNamed("fart29.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart35.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("fart37.wav", waitForCompletion: false),
//        ]
//
//    let toiletFlushes = [
//        SKAction.playSoundFileNamed("toilet-flush1.wav", waitForCompletion: false),
//        SKAction.playSoundFileNamed("toilet-flush2.wav", waitForCompletion: false)
//        ]
//
//    let toiletFlushHighScore = SKAction.playSoundFileNamed("toilet-flush-highscore.wav", waitForCompletion: false)
//    let counterFart = SKAction.playSoundFileNamed("AirBiscuit.mp3", waitForCompletion: false)
//
//
//
//    override init(size: CGSize) {
//        super.init(size: size)
//    }
//
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")   // 6
//    }
//
//    override func didMove(to view: SKView) {
//
//
//        print("\(#file):\(#line) : \(#function)")
//        print("\n\nDid Move To...\n\n")
//        setupGame()
//
//
////        let toiletScene = SKScene(fileNamed: "Toilet")!
////        let theToilet = toiletScene.childNode(withName: "toilet_body") as! SKSpriteNode
////
////        theToilet.position = CGPoint(x: 100, y: 100)
////        theToilet.zPosition = 2
////
////        self.addChild(theToilet)
//
//
//        enumerateChildNodes(withName: "//*", using: { node, _ in
//            if let eventListenerNode = node as? EventListenerNode {
//                eventListenerNode.didMoveToScene()
//            }
//        })
//    }
//
//    func setupGame() {
//        startGame()
//    }
//
//
//    func startGame() {
//        targetCount    = 0
//        targetsCreated = 0
//        gameState      = .start
//        startTime      = Date()
//
//        setupHUD(startTime: startTime)
//        startCreatingTargets()
//    }
//
//
//    func startCreatingTargets() {
//        gameState = .playing
//
//        timer = Timer.scheduledTimer(withTimeInterval: targetCreationRate, repeats: true) { timer in
//            self.createTarget()
//        }
//    }
//
//
//    func setupHUD(startTime: Date) {
//        self.addChild(hud)
//        hud.addTimer(startTime: startTime)
//        hud.addRemainingTurdsLabel()
//    }
//
//
//    func createTarget() {
//        if targetsCreated == maxTargets {
//            timer?.invalidate()
//            timer = nil
//            return
//        }
//
//        print("Call to createTarget()")
//
//        let randomFart = Int.random(targetCreationFarts.count)
//        run(targetCreationFarts[randomFart])
//
//        targetsCreated += 1
//        targetCount    += 1
//
//        print("Targets Created: \(targetsCreated)")
//        print("Target Count: \(targetCount)\n")
//
//        // find the scene view we are drawing into
//        guard let sceneView = self.view as? ARSKView else { return }
//
//        // get access to a random number generator
//        let random = GKRandomSource.sharedRandom()
//
//        // create a random X rotation
////        let xRotation = simd_float4x4(SCNMatrix4MakeRotation(Float.pi * 2 * random.nextUniform(), 1, 0, 0))
//        let xRotation = simd_float4x4(SCNMatrix4MakeRotation(0, 1, 0, 0))
//
//        // create a random Y rotation
////        let yRotation = simd_float4x4(SCNMatrix4MakeRotation(Float.pi * 2 * random.nextUniform(), 0, 1, 0))
//        let yRotation = simd_float4x4(SCNMatrix4MakeRotation(0, 0, 1, 0))
//
//        // combine them together
//        let rotation = simd_mul(xRotation, yRotation)
//
//        // move forward 1.5 meters into the screen
//        var translation = matrix_identity_float4x4
//        translation.columns.3.z = -1.5
//
//        // combine that with the rotation
//        let transform = simd_mul(rotation, translation)
//
//        // create an anchor at the finished position
//        let anchor = ARAnchor(transform: transform)
//        sceneView.session.add(anchor: anchor)
//
//        print("New Turd at: \(anchor.debugDescription)")
//    }
//
//
//
//    func gameOver() {
//        print("\n\nFLUSHING\n\n")
//        run(toiletFlushHighScore)
//
////        let messageBox = MessageBox()
////        messageBox.createMessageBox(size: CGSize(width: 400, height: 300), message: "Test")
////
////        messageBox.position = .zero
////        self.addChild(messageBox)
//
//
//
//
//        // Don't present it yet...
//
//
////        // Build the menu scene:
////        let menuScene = MenuScene()
////        menuScene.size = self.view!.bounds.size
////        // Show the menu
////        self.view!.presentScene(menuScene)
//    }
//
//
//
//
//
//
//    func restartGame() {
//
//    }
//
//
//    func checkEndGame() {
//        if targetsCreated == maxTargets && targetCount == 0 {
//            gameState = .win
//        }
//    }
//
//
//
//    override func update(_ currentTime: TimeInterval) {
//        // Called before each frame is rendered
//        hud.updateTimer()
//
//        checkEndGame()
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//
//        let location = touch.location(in: self)
//        let hit      = nodes(at: location)
//
//
//        if let sprite = hit.first as? TurdNode {
//            let randomFart = Int.random(shortFarts.count)
//            run(shortFarts[randomFart])
//            sprite.wasTapped()
//            targetCount -= 1
//        }
//
//    }
//
//
//
//}
//
//
//extension SKReferenceNode {
//    func getBasedChildNode () -> SKNode? {
//        if let child = self.children.first?.children.first {return child}
//        else {return nil}
//    }
//}
//
//
