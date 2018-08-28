//
//  SpriteAbility.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 23/08/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public typealias SpriteAbilityBlock = ((_ hero: SpriteTarget & SpriteAbility) -> ())

public protocol SpriteAbility: class {
    var abilityCount: Int { get set } // current
    var abilityActivate: Int { get } // max
    var abilityBlock: SpriteAbilityBlock { get }
}

public struct SpriteAbilityData {
    var start: Int
    var activate: Int
    var block: SpriteAbilityBlock
    
    public init(start: Int, activate: Int, block: @escaping SpriteAbilityBlock) {
        self.start = start
        self.activate = activate
        self.block = block
    }
}
