//
//  SpriteEffect.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 20/08/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public class SpriteEffect: Sprite {
    
    public init(type: SpriteEffectIndex, interval: TimeInterval) {
        let textures = SpriteEffect.texturesGet(type: type)
        
        super.init(texture: textures.first!, color: UIColor.clear, size: textures.first!.size())
        self.run(SKAction.animate(with: textures, timePerFrame: interval, resize: true, restore: false)) {
            self.removeFromParent()
        }
    }
    
    public init(type: SpriteEffectIndex, interval: TimeInterval, position: CGPoint) {
        let textures = SpriteEffect.texturesGet(type: type)
        
        super.init(texture: textures.first!, color: UIColor.clear, size: textures.first!.size())
        self.position = position
        self.run(SKAction.animate(with: textures, timePerFrame: interval, resize: true, restore: false)) {
            self.removeFromParent()
        }
    }
    
    public init(loopType: SpriteEffectIndex, interval: TimeInterval) {
        let textures = SpriteEffect.texturesGet(type: loopType)
        
        super.init(texture: textures.first!, color: UIColor.clear, size: textures.first!.size())
        self.run(SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: interval, resize: true, restore: false)))
    }
    
    public init(loopType: SpriteEffectIndex, interval: TimeInterval, position: CGPoint) {
        let textures = SpriteEffect.texturesGet(type: loopType)
        
        super.init(texture: textures.first!, color: UIColor.clear, size: textures.first!.size())
        self.position = position
        self.run(SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: interval, resize: true, restore: false)))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension Sprite {
    
    @discardableResult public func effect(type: SpriteEffectIndex, interval: TimeInterval = 0.1) -> SpriteEffect {
        let effect = SpriteEffect.init(type: type, interval: interval)
        
        self.addChild(effect)
        return effect
    }
    
    @discardableResult public func effectLoop(type: SpriteEffectIndex, interval: TimeInterval = 0.1) -> SpriteEffect {
        let effect = SpriteEffect.init(type: type, interval: interval)
        
        self.addChild(effect)
        return effect
    }
}

public extension SpriteCreature {
    
    public func effectProjectileDelayed(type: SpriteEffectIndex, position: CGPoint,
                                        parent: SKNode, interval: TimeInterval = 0.1, completion: (() -> ())? = nil) {
        let start = self.cycleInterval / 2
        
        self.run(SKAction.wait(forDuration: start)) {
            let effect = SpriteEffect.init(type: type, interval: interval)
            
            effect.position = self.position
            parent.addChild(effect)
            if let block = completion {
                effect.run(SKAction.move(to: position, duration: start)) {
                    block()
                }
            }
            else {
                effect.run(SKAction.move(to: position, duration: start))
            }
        }
    }
    
    public func effectProjectileDelayed(type: SpriteEffectIndex, target: SKNode,
                                        parent: SKNode, interval: TimeInterval = 0.1, completion: (() -> ())? = nil) {
        let start = self.cycleInterval / 2
        
        self.run(SKAction.wait(forDuration: start)) {
            let effect = SpriteEffect.init(type: type, interval: interval)
            
            effect.position = self.position
            parent.addChild(effect)
            if let block = completion {
                effect.run(SKAction.move(to: target.position, duration: start)) {
                    block()
                }
            }
            else {
                effect.run(SKAction.move(to: target.position, duration: start))
            }
        }
    }
    
    public func effectProjectileDelayedWithCompletion(type: SpriteEffectIndex, impact: SpriteEffectIndex,
                                                      position: CGPoint, parent: SKNode,
                                                      interval: TimeInterval = 0.1, completion: (() -> ())? = nil) {
        let start = self.cycleInterval / 2
        
        self.run(SKAction.wait(forDuration: start)) {
            let effect = SpriteEffect.init(type: type, interval: interval)
            
            effect.position = self.position
            parent.addChild(effect)
            effect.run(SKAction.move(to: position, duration: start)) {
                let effect = SpriteEffect.init(type: impact, interval: interval)
                
                effect.position = position
                parent.addChild(effect)
                completion?()
            }
        }
    }
    
    public func effectProjectileDelayedWithCompletion(type: SpriteEffectIndex, impact: SpriteEffectIndex,
                                                      target: SKNode, parent: SKNode,
                                                      interval: TimeInterval = 0.1, completion: (() -> ())? = nil) {
        let start = self.cycleInterval / 2
        
        self.run(SKAction.wait(forDuration: start)) {
            let effect = SpriteEffect.init(type: type, interval: interval)
            
            effect.position = self.position
            parent.addChild(effect)
            effect.run(SKAction.move(to: target.position, duration: start)) {
                let impactEffect = SpriteEffect.init(type: impact, interval: interval)
                
                impactEffect.position = target.position
                parent.addChild(impactEffect)
                completion?()
            }
        }
    }
    
}

public enum SpriteEffectIndex: Int {
    case tornado = 0
    case loopVoltanicaShiny = 1
    case loopMonsterShield = 2
    case lightBlueBallExplode = 3
    case electricBall2 = 4
    case demonisteShield = 5
    case cirinaHit = 6
    case voltanicaShield = 7
    case FreezeShield = 8
    case loopShieldSkelShiny = 9
    case treanDeploy = 10
    case anubisTransofrm = 11
    case loseBlueShield = 12
    case fireBallImpact = 13
    case demonBlast = 14
    case purpleLightRockyExplosion = 15
    case canonExplode = 16
    case cirinaHit2 = 17
    case greenImpact = 18
    case loopBelierAnnulate = 19
    case loopRedSkull = 20
    case hache = 21
    case loopTripleElectric = 22
    case kickExplosionColored = 23
    case demonSmallImpact = 24
    case lightBells = 25
    case loopSmokeLittleFire = 26
    case blast = 27
    case pinkExplode = 28
    case sphericalLightImpact = 29
    case paladinshield = 30
    case groundHardImpact = 31
    case fireShield = 32
    case loopFireBall = 33
    case tricolorBallExplode = 34
    case belierAnnulate = 35
    case groundFireImpact = 36
    case artificExplode = 37
    case electricImpact = 38
    case greenBallExplode = 39
    case loopSkeletaur = 40
    case groundLightFireBallExplode = 41
    case electricalSmallBallExplode = 42
    case loopRedRay = 43
    case smokeExplosion = 44
    case loopBurn = 45
    case FireHotExplode = 46
    case pikaOrbeExplode = 47
    case loopMaracas = 48
    case electricStorm = 49
    case fireImpact = 50
    case anubisCondanation = 51
    case marauderShield = 52
    case redExplodeSmall = 53
    case mysticBall = 54
    case loopBigFire = 55
    case loopShaman = 56
    case kickExplosion = 57
    case lightPurpleImpact = 58
    case explosion = 59
    case demonTransorm = 60
    case loopElectricBall = 61
    case electricBallImpact = 62
    case FireSmokeEffect = 63
    case electricImpact2 = 64
    case blueSplash = 65
    case skullExplode = 66
    case pinkSplash = 67
    case loopSwordFire = 68
    case treanDamage = 69
    case redExplode = 70
    case valentinaTornado = 71
    case fireDamage = 72
    case loopAnubis = 73
    case orksbaneSmash = 74
    case purpleBallExplode = 75
    case loopMysticTornado = 76
    case loopBlueFire = 77
    case voltanicaShinyBallExplode = 78
    case blueEffect = 79
    case phatomKingExplode = 80
    case rockImpact = 81
    case loopAnubisShiny = 82
    case loopBlueCristal = 83
    case fireExplodeToDark = 84
    case shield = 85
    case valentinaEffect = 86
    case fireBalldesintegrate = 87
    case purpleSpacyImpact = 88
    case mysticExplosion = 89
    
    fileprivate var associatedData: (folder: String, textureCount: Int) {
        return SpriteEffectIndexData[self.rawValue]
    }
}

fileprivate let SpriteEffectIndexData: [(folder: String, textureCount: Int)] = [
    ("effect_tornado.atlas", 15),
    ("effect_loopVoltanicaShiny.atlas", 5),
    ("effect_loopMonsterShield.atlas", 5),
    ("effect_lightBlueBallExplode.atlas", 4),
    ("effect_electricBall2.atlas", 3),
    ("effect_demonisteShield.atlas", 5),
    ("effect_cirinaHit.atlas", 6),
    ("effect_voltanicaShield.atlas", 6),
    ("effect_FreezeShield.atlas", 3),
    ("effect_loopShieldSkelShiny.atlas", 3),
    ("effect_treanDeploy.atlas", 10),
    ("effect_anubisTransofrm.atlas", 10),
    ("effect_loseBlueShield.atlas", 9),
    ("effect_fireBallImpact.atlas", 6),
    ("effect_demonBlast.atlas", 6),
    ("effect_purpleLightRockyExplosion.atlas", 7),
    ("effect_canonExplode.atlas", 13),
    ("effect_cirinaHit2.atlas", 5),
    ("effect_greenImpact.atlas", 3),
    ("effect_loopBelierAnnulate.atlas", 4),
    ("effect_loopRedSkull.atlas", 0),
    ("effect_hache.atlas", 5),
    ("effect_loopTripleElectric.atlas", 8),
    ("effect_kickExplosionColored.atlas", 4),
    ("effect_demonSmallImpact.atlas", 8),
    ("effect_lightBells.atlas", 4),
    ("effect_loopSmokeLittleFire.atlas", 10),
    ("effect_blast.atlas", 7),
    ("effect_pinkExplode.atlas", 3),
    ("effect_sphericalLightImpact.atlas", 6),
    ("effect_paladinshield.atlas", 5),
    ("effect_groundHardImpact.atlas", 10),
    ("effect_fireShield.atlas", 5),
    ("effect_loopFireBall.atlas", 3),
    ("effect_tricolorBallExplode.atlas", 4),
    ("effect_belierAnnulate.atlas", 6),
    ("effect_groundFireImpact.atlas", 6),
    ("effect_artificExplode.atlas", 9),
    ("effect_electricImpact.atlas", 4),
    ("effect_greenBallExplode.atlas", 5),
    ("effect_loopSkeletaur.atlas", 5),
    ("effect_groundLightFireBallExplode.atlas", 8),
    ("effect_electricalSmallBallExplode.atlas", 5),
    ("effect_loopRedRay.atlas", 5),
    ("effect_smokeExplosion.atlas", 6),
    ("effect_loopBurn.atlas", 4),
    ("effect_FireHotExplode.atlas", 6),
    ("effect_pikaOrbeExplode.atlas", 5),
    ("effect_loopMaracas.atlas", 4),
    ("effect_electricStorm.atlas", 6),
    ("effect_fireImpact.atlas", 5),
    ("effect_anubisCondanation.atlas", 10),
    ("effect_marauderShield.atlas", 4),
    ("effect_redExplodeSmall.atlas", 3),
    ("effect_mysticBall.atlas", 4),
    ("effect_loopBigFire.atlas", 5),
    ("effect_loopShaman.atlas", 4),
    ("effect_kickExplosion.atlas", 4),
    ("effect_lightPurpleImpact.atlas", 6),
    ("effect_explosion.atlas", 6),
    ("effect_demonTransorm.atlas", 10),
    ("effect_loopElectricBall.atlas", 4),
    ("effect_electricBallImpact.atlas", 5),
    ("effect_FireSmokeEffect.atlas", 5),
    ("effect_electricImpact2.atlas", 3),
    ("effect_blueSplash.atlas", 5),
    ("effect_skullExplode.atlas", 8),
    ("effect_pinkSplash.atlas", 3),
    ("effect_loopSwordFire.atlas", 7),
    ("effect_treanDamage.atlas", 7),
    ("effect_redExplode.atlas", 9),
    ("effect_valentinaTornado.atlas", 3),
    ("effect_fireDamage.atlas", 7),
    ("effect_loopAnubis.atlas", 6),
    ("effect_orksbaneSmash.atlas", 5),
    ("effect_purpleBallExplode.atlas", 5),
    ("effect_loopMysticTornado.atlas", 8),
    ("effect_loopBlueFire.atlas", 4),
    ("effect_voltanicaShinyBallExplode.atlas", 5),
    ("effect_blueEffect.atlas", 5),
    ("effect_phatomKingExplode.atlas", 5),
    ("effect_rockImpact.atlas", 10),
    ("effect_loopAnubisShiny.atlas", 0),
    ("effect_loopBlueCristal.atlas", 4),
    ("effect_fireExplodeToDark.atlas", 5),
    ("effect_shield.atlas", 6),
    ("effect_valentinaEffect.atlas", 8),
    ("effect_fireBalldesintegrate.atlas", 5),
    ("effect_purpleSpacyImpact.atlas", 5),
    ("effect_mysticExplosion.atlas", 7)
]

public extension SpriteEffect {
    
    fileprivate static var texturesEffect: [SpriteEffectIndex : (atlas: SKTextureAtlas, textures: [SKTexture])] = [:]
    
    @inline (__always) fileprivate class func texturesLoad(type: SpriteEffectIndex) {
        let data = type.associatedData
        let atlas = SKTextureAtlas.init(named: data.folder)
        var textures: [SKTexture] = []
        
        for index in 0...data.textureCount - 1 {
            textures.append(atlas.textureNamed("0_\(index)"))
        }
        SpriteEffect.texturesEffect[type] = (atlas, textures)
    }
    
    public class func texturesCharge(type: SpriteEffectIndex) {
        SpriteEffect.texturesLoad(type: type)
    }
    
    public class func texturesCharge(types: [SpriteEffectIndex]) {
        SpriteEffect.texturesEffect.removeAll()
        for type in types {
            SpriteEffect.texturesLoad(type: type)
        }
    }
    
    fileprivate class func texturesGet(type: SpriteEffectIndex) -> [SKTexture] {
        guard let effect = SpriteEffect.texturesEffect[type] else {
            SpriteEffect.texturesLoad(type: type)
            
            if let effect = SpriteEffect.texturesEffect[type] {
                return effect.textures
            }
            fatalError("no textures atlas " + type.associatedData.folder)
        }
        
        return effect.textures
    }
    
}
