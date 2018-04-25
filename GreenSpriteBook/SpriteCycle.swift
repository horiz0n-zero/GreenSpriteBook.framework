//
//  SpriteCycle.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 08/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//
import Foundation
import SpriteKit

public protocol SpriteCycle {
    var cycleInterval: TimeInterval { get set }
    var cycleWork: (() -> ())? { get set }
    var cycleWorkDie: (() -> ())? { get set }
    var cycleDie: Bool { get set }
}

public extension SpriteCycle where Self: SKNode {
    
    public func startCycle() {
        
        if let work = self.cycleWork {
            work()
        }
        self.run(SKAction.wait(forDuration: self.cycleInterval), completion: {
            if self.cycleDie == false {
                return self.startCycle()
            }
            if let dieWork = self.cycleWorkDie {
                dieWork()
            }
        })
        
    }
    
}



