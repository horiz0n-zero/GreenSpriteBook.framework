//
//  Cycle.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 05/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

/// object that adopt this protocol can be manipulated by cycleManager
public protocol Cycle {
    /// Required. The cyclique work to done while the cycle is not dead.
    var cycleWork: DispatchWorkItem! { get set }
    /** `Required`. Executed when the last cycleWork is done.
        
        cycleWork and cycleDie have to be nil when done
     */
    var cycleWorkDie: (() -> ())! { get set }
    /// set this properties to `true` for stopping the next call
    var cycleIsDie: Bool { get set }
    /// The time interval before next `cycle object work` will be executed.
    var cycleInterval: TimeInterval { get set }
    /// a `open bar` data
    var cycleRawValue: Int { get set }
}

/// a protocol that manage cycle objects
public protocol CycleManager {
    /// The queue that will execute cyclique objects work.
    var cycleQueue: DispatchQueue { get set }
    /// All cycle objects work will be executed in this group.
    var cycleGroup: DispatchGroup { get set }
    /// A semaphore for limit access to resources and method in the cycleManager
    var cycleSemaphore: DispatchSemaphore { get set }
}

public extension CycleManager {
    
    /// Start an async cyclique execution on cycleObject
    /// - parameter cycleObject: the object entering in cycle
    public func cycleExecute(_ cycleObject: Cycle) {
        let time = DispatchTime.now() + cycleObject.cycleInterval
        
        self.cycleQueue.async(group: self.cycleGroup, execute: cycleObject.cycleWork)
        self.cycleQueue.asyncAfter(deadline: time, execute: {
            if cycleObject.cycleIsDie {
                cycleObject.cycleWorkDie()
                return
            }
            self.cycleExecute(cycleObject)
        })
    }
    
    /**
     Initialize a cycleManager object with these properties :
     - .userInteractive
     - .concurrent
     - .inherit
     - parameter fill: a CycleManager object
     - parameter label: the label of the queue
    */
    static func concurrentCycleManager<T: CycleManager>(_ fill: inout T, label: String) {
        fill.cycleQueue = DispatchQueue(label: label, qos: .userInteractive,
                                        attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        fill.cycleGroup = DispatchGroup()
    }
    
    /// modify scene value or acces method from cycleobject
    public func modify(_ block: @escaping () -> ()) {
        self.cycleSemaphore.wait()
        block()
        self.cycleSemaphore.signal()
    }
    
}
