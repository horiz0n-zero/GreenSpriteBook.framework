//
//  SpriteStat.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 20/08/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public protocol SpriteStat: class {
    var statLife: CGFloat! { get set }
    var statAttack: CGFloat! { get set }
    var statMove: CGFloat! { get set }
    var statRange: CGFloat! { get set }
    var statBase: SpriteStatBase { get set }
    var statBaseType: SpriteStatIndex { get set }
    var statLevel: Int { get set }
}

public protocol SpriteStatIndex { }

open class SpriteStatBase: NSObject {
    public let life: CGFloat
    public let attack: CGFloat
    public let move: CGFloat
    public let range: CGFloat
    public let cycleInterval: TimeInterval
    public let type: SpriteStatIndex
    
    public init(type: SpriteStatIndex, life: CGFloat, attack: CGFloat, move: CGFloat, range: CGFloat, cycleInterval: TimeInterval) {
        self.type = type
        self.life = life
        self.attack = attack
        self.move = move
        self.range = range
        self.cycleInterval = cycleInterval
        super.init()
    }
    
    @inline (__always) public func calculate<Target: Sprite & SpriteStat>(_ sprite: Target) {
        let squared = sqrt(pow(sprite.size.width, 2) + pow(sprite.size.height, 2))
        
        sprite.statLife = self.life
        sprite.statAttack = self.attack
        sprite.statMove = self.move * squared
        sprite.statRange = self.range * squared
    }
}

open class SpriteStatBaseLevel: SpriteStatBase {
    public enum Calculus {
        case baseValueAreMaxLevel
        case baseAddPercentAtEachLevel(CGFloat)
        case baseAddConstantValue(CGFloat, CGFloat)
    }
    public let maxLevel: Int
    public let calculus: SpriteStatBaseLevel.Calculus
    
    public init(type: SpriteStatIndex, life: CGFloat, attack: CGFloat, move: CGFloat, range: CGFloat, cycleInterval: TimeInterval, maxLevel: Int, calculus: SpriteStatBaseLevel.Calculus) {
        self.maxLevel = maxLevel
        self.calculus = calculus
        super.init(type: type, life: life, attack: attack, move: move, range: range, cycleInterval: cycleInterval)
    }
    
    @inline (__always) public override func calculate<Target: Sprite & SpriteStat>(_ sprite: Target) {
        
         let squared = sqrt(pow(sprite.size.width, 2) + pow(sprite.size.height, 2))
         
         switch self.calculus {
         case .baseValueAreMaxLevel:
             let percent = CGFloat(sprite.statLevel) / CGFloat(self.maxLevel)
             
             sprite.statLife = self.life * percent
             sprite.statAttack = self.attack * percent
         case .baseAddPercentAtEachLevel(let percent):
             sprite.statLife = self.life + (self.life * percent) * CGFloat(sprite.statLevel)
             sprite.statAttack = self.attack + (self.attack * percent) * CGFloat(sprite.statLevel)
         case .baseAddConstantValue(let life, let attack): // -1 ?
             sprite.statLife = self.life + (life * CGFloat(sprite.statLevel))
             sprite.statAttack = self.attack + (attack * CGFloat(sprite.statLevel))
         }
         sprite.statMove = self.move * squared
         sprite.statRange = self.range * squared
        
    }
    
}
