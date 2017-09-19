//
//  TurdNode.swift
//  Turd Herder
//
//  Created by Brent Michalski on 7/30/17.
//  Copyright © 2017 Brent Michalski. All rights reserved.
//

import UIKit
import SpriteKit

class TurdNode: SKSpriteNode {

    let turdImages = [
        SKTexture(imageNamed: "turd01"),
        SKTexture(imageNamed: "turd02"),
        SKTexture(imageNamed: "turd03"),
        SKTexture(imageNamed: "turd04"),
        SKTexture(imageNamed: "turd05")
        ]
    
        
    init() {
//        let texture = SKTexture(imageNamed: "turd")
        
        let texture = turdImages[Int.random(turdImages.count)]
        
        let poopSize = CGSize(width: 125, height: 125)
        super.init(texture: texture, color: .clear, size: poopSize)
        
        name = "turd"
        
        let smoke:SKEmitterNode = smokeRising()
        smoke.position          = self.position
        self.addChild(smoke)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func wasTapped() {
        let blast:SKEmitterNode = explosion(intensity: 4.0)
        addChild(blast)
        
        let scaleOut = SKAction.scale(to: 2, duration: 0.2)
        let fadeOut  = SKAction.fadeOut(withDuration: 0.5)
        let group    = SKAction.group([scaleOut, fadeOut])
        let sequence = SKAction.sequence([group, SKAction.removeFromParent()])
        self.run(sequence)
    }
    
    
    // MARK: - Particles
    func smokeRising() -> SKEmitterNode {
        let emitter         = SKEmitterNode()
        let particleTexture = SKTexture(imageNamed: "spark")
        
        emitter.name                          = "turd"
        emitter.zPosition                     = -2
        emitter.particleTexture               = particleTexture
        
        emitter.particleBirthRate             = 40
        
        emitter.particleLifetime              = 10
        emitter.particleLifetimeRange         = 0
        
        emitter.particlePositionRange.dx      = 40
        emitter.particlePositionRange.dy      = 5
        
        emitter.particleZPosition             = 0
        
        emitter.emissionAngle                 = CGFloat(90.0).degreesToRadians()
        emitter.emissionAngleRange            = CGFloat(20.0).degreesToRadians()
        emitter.particleSpeed                 = 40
        emitter.particleSpeedRange            = 40
        
        emitter.xAcceleration                 = 0
        emitter.yAcceleration                 = 10
        
        emitter.particleAlpha                 = 0.4
        emitter.particleAlphaRange            = 0.3
        emitter.particleAlphaSpeed            = -0.15
        
        emitter.particleScale                 = 0.5
        emitter.particleScaleRange            = 0.3
        emitter.particleScaleSpeed            = 0.5
        
        emitter.particleColor                 = SKColor.init(red: 79.0/255.0, green: 143.0/255.0, blue: 0.0, alpha: 1.0)
        emitter.particleColorBlendFactor      = 1
        emitter.particleColorBlendFactorRange = 0
        emitter.particleColorBlendFactorSpeed = 0
        
        emitter.particleBlendMode             = SKBlendMode.alpha
        
        return emitter
    }

    
    func explosion(intensity: CGFloat) -> SKEmitterNode {
        let emitter         = SKEmitterNode()
        let particleTexture = SKTexture(imageNamed: "spark")

        emitter.zPosition                = 2
        emitter.particleTexture          = particleTexture
        emitter.particleBirthRate        = 4000 * intensity
        emitter.numParticlesToEmit       = Int(400 * intensity)
        emitter.particleLifetime         = 1.0
        emitter.emissionAngle            = CGFloat(90.0).degreesToRadians()
        emitter.emissionAngleRange       = CGFloat(360.0).degreesToRadians()
        emitter.particleSpeed            = 500 * intensity
        emitter.particleSpeedRange       = 500 * intensity
        emitter.particleAlpha            = 1.0
        emitter.particleAlphaRange       = 0.25
        emitter.particleAlphaSpeed       = -1
        
        emitter.particleScale            = 0.3
        emitter.particleScaleRange       = 0.2
        emitter.particleScaleSpeed       = -0.4
        emitter.particleColor            = SKColor.brown
        emitter.particleColorBlendFactor = 1
        emitter.particleBlendMode        = SKBlendMode.alpha
        emitter.run(SKAction.removeFromParentAfterDelay(2.0))

        return emitter
    }
    
}
