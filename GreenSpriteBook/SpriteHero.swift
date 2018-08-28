//
//  SpriteHero.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 20/08/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

open class SpriteHero: SpriteCreature, SpriteAbility {
    public var abilityCount: Int
    public var abilityActivate: Int
    public var abilityBlock: SpriteAbilityBlock
    
    public init(base: SpriteStatBase, ability: SpriteAbilityData, sideable: SpriteSideable, side: SpriteSideableContainer.SideType, level: Int) {
        self.abilityCount = ability.start
        self.abilityActivate = ability.activate
        self.abilityBlock = ability.block
        super.init(base: base, sideable: sideable, side: side, level: level)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}

public extension SpriteCycle where Self: SpriteHero {
    
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
