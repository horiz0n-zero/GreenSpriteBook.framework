//
//  SpriteContinuousAbility.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 23/08/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public typealias SpriteContinuousAbilityBlock = ((_ spirit: SpriteTarget & SpriteContinuousAbility) -> ())

public protocol SpriteContinuousAbility: class {
    var continuousInterval: TimeInterval { get set }
    var continuousBlock: SpriteContinuousAbilityBlock { get }
}

public let SpriteContinuousActionKey: String = "SpriteContinuous"
public extension SpriteContinuousAbility where Self: SpriteTarget {
    
    @inline (__always) public func continuousAbilityStart() {
        self.run(SKAction.repeatForever(SKAction.sequence([
                SKAction.wait(forDuration: self.continuousInterval),
                SKAction.run {
                    self.continuousBlock(self)
            }
            ])), withKey: SpriteContinuousActionKey)
    }
    
    @inline (__always) public func continuousAbilityStop() {
        self.removeAction(forKey: SpriteContinuousActionKey)
    }
}

public struct SpriteContinuousAbilityData {
    var interval: TimeInterval
    var block: SpriteContinuousAbilityBlock
    
    public init(interval: TimeInterval, block: @escaping SpriteContinuousAbilityBlock) {
        self.interval = interval
        self.block = block
    }
}
