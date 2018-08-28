//
//  SpriteMonster.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 20/08/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

open class SpriteMonster: SpriteCreature, SpriteAbility, SpriteContinuousAbility {
    public var abilityCount: Int
    public var abilityActivate: Int
    public var abilityBlock: SpriteAbilityBlock
    
    public var continuousInterval: TimeInterval
    public var continuousBlock: SpriteContinuousAbilityBlock
    
    public init(base: SpriteStatBase, abilityData: SpriteAbilityData, continuousData: SpriteContinuousAbilityData,
                         sideable: SpriteSideable, side: SpriteSideableContainer.SideType, level: Int = 1) {
        self.abilityCount = abilityData.start
        self.abilityActivate = abilityData.activate
        self.abilityBlock = abilityData.block
        self.continuousInterval = continuousData.interval
        self.continuousBlock = continuousData.block
        super.init(base: base, sideable: sideable, side: side, level: level)
        self.continuousAbilityStart()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
}

public extension SpriteCycle where Self: SpriteMonster {
    
    @inline (__always) public func cycleStart() {
        if self.abilityCount >= self.abilityActivate {
            self.abilityCount = 0
            self.ccAnimableAction = .attack
            self.ccAnimate()
            self.abilityBlock(self)
        }
        else {
            self.cycleWork()
        }
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: self.cycleInterval),
            SKAction.run {
                if self.cycleDead {
                    self.cycleWorkDie?()
                }
                else {
                    return self.cycleStart()
                }
            }
        ]), withKey: SpriteCycleActionKey)
    }
    
}
