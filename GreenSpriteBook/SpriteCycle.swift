//
//  SpriteCycle.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 20/08/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public protocol SpriteCycle: class {
    var cycleInterval: TimeInterval { get set }
    var cycleWork: (() -> ())! { get set }
    var cycleWorkDie: (() -> ())? { get set }
    var cycleDead: Bool { get set }
}

public let SpriteCycleActionKey: String = "SpriteCycle"
public extension SpriteCycle where Self: SKNode {
    
    @inline (__always) public func cycleStart() {
        self.cycleWork()
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
    
    @inline (__always) public func cycleStop() {
        if let action = self.action(forKey: SpriteCycleActionKey) {
            action.speed = 0
        }
    }
    
    @inline (__always) public func cycleRestart() {
        if let action = self.action(forKey: SpriteCycleActionKey) {
            action.speed = 1
        }
    }
    
    @inline (__always) public func cycleBreak() {
        self.removeAction(forKey: SpriteCycleActionKey)
        if !self.cycleDead {
            self.cycleStart()
        }
        else {
            self.cycleWorkDie?()
        }
    }
    
}
