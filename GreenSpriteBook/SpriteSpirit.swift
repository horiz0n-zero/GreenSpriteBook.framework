//
//  SpriteSpirit.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 20/08/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

open class SpriteSpirit: SpriteCreature, SpriteContinuousAbility {
    public var continuousInterval: TimeInterval
    public var continuousBlock: SpriteContinuousAbilityBlock
    
    public init(base: SpriteStatBase, continuousAbility: SpriteContinuousAbilityData,
                         sideable: SpriteSideable, side: SpriteSideableContainer.SideType, level: Int = 1) {
        self.continuousInterval = continuousAbility.interval
        self.continuousBlock = continuousAbility.block
        super.init(base: base, sideable: sideable, side: side, level: level)
        self.continuousAbilityStart()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("")
    }
    
}
