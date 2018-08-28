//
//  SpriteSideable.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 20/08/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public struct SpriteSideableContainer {
    
    public var sides: [[SpriteTarget]]
    public var sideNumber: Int
    
    public enum SideType {
        case freeForAll
        case unic(Int)
    }
    
    public init(sideNumber: Int) {
        self.sideNumber = sideNumber
        self.sides = Array.init(repeating: [], count: self.sideNumber + 1)
    }
    
    public mutating func append(_ sideElement: SpriteTarget) {
        
        switch sideElement.side {
        case .unic(let index):
            self.sides[index].append(sideElement)
        default:
            self.sides[self.sideNumber].append(sideElement)
        }
    }
    
    public mutating func remove(_ sideElement: SpriteTarget) {
        
        switch sideElement.side {
        case .unic(let index):
            for (i, element) in self.sides[index].enumerated() { // :/ !
                if element == sideElement {
                    self.sides[index].remove(at: i)
                    break
                }
            }
        default:
            for (index, element) in self.sides[self.sideNumber].enumerated() {
                if element == sideElement {
                    self.sides[self.sideNumber].remove(at: index)
                }
            }
        }
    }
}

public protocol SpriteSideable: class {
    
    var sideableContainer: SpriteSideableContainer { get set }
}

public protocol SpriteSide {
    
    var sideable: SpriteSideable { get }
    var side: SpriteSideableContainer.SideType { get }
}

public typealias SpriteTarget = Sprite & SpriteSide & SpriteStat
public typealias SpriteTargetable = (target: SpriteTarget, distance: CGFloat)

public extension SpriteSide where Self: SpriteTarget {
    
    @inline (__always) fileprivate func getEnemies() -> [SpriteTargetable] {
        switch self.side {
        case .unic(let index):
            var targetArray: [SpriteTarget] = []
            var result: [SpriteTargetable] = []
            
            for (targetIndex, targets) in self.sideable.sideableContainer.sides.enumerated() {
                if targetIndex == index {
                    continue
                }
                targetArray += targets
            }
            result = targetArray.map { element in
                return (element, self.distance(to: element))
            }
            result.sort { element1, element2 -> Bool in
                return element1.distance < element2.distance
            }
            return result
        case .freeForAll:
            var targetArray: [SpriteTarget] = []
            var result: [SpriteTargetable] = []
            
            for targets in self.sideable.sideableContainer.sides[0 ..< self.sideable.sideableContainer.sideNumber] {
                targetArray += targets
            }
            result = targetArray.map { element in
                return (element, self.distance(to: element))
            }
            result.sort { element1, element2 -> Bool in
                element1.distance < element2.distance
            }
            return result
        }
    }
    
    public func sideGetEnemieInRange() -> SpriteTargetable? {
        let array = getEnemies()
        
        if let inRange = array.first, inRange.distance <= self.statRange {
            return inRange
        }
        return nil
    }
    
    public func sideGetEnemiesInRange() -> [SpriteTargetable] {
        let array = getEnemies()
        
        return array.filter { element -> Bool in
            return element.distance <= self.statRange
        }
    }
    public func sideGetEnemiesInRange(count: Int) -> ArraySlice<SpriteTargetable> {
        var array = getEnemies()
        
        array = array.filter { element -> Bool in
            return element.distance <= self.statRange
        }
        if array.count < count {
            if array.count == 0 {
                return []
            }
            return array[0 ..< array.count - 1]
        }
        return array[0 ..< count]
    }
    
    public func sideGetEnemie() -> SpriteTargetable? {
        let array = getEnemies()
        
        if let first = array.first {
            return first
        }
        return nil
    }
    
    public func sideGetEnemies() -> [SpriteTargetable] {
        return getEnemies()
    }
    public func sideGetEnemies(count: Int) -> ArraySlice<SpriteTargetable> {
        let array = getEnemies()
        
        if array.count < count {
            if array.count == 0 {
                return []
            }
            return array[0 ..< array.count - 1]
        }
        return array[0 ..< count]
    }
    
}

public extension SpriteSide where Self: SpriteTarget {
    
    func getFriends() -> [SpriteTargetable] {
        switch self.side {
        case .unic(let index):
            var newArray: [SpriteTargetable] = self.sideable.sideableContainer.sides[index].map { element in
                return (element, self.distance(to: element))
            }
            
            newArray.sort { element1, element2 -> Bool in
                return element1.distance < element2.distance
            }
            newArray = newArray.filter { element in
                return element.target !== self
            }
            return newArray
        case .freeForAll:
            return [] // ? no friends ?
        }
    }
    
    public func sideGetFriendInRange() -> SpriteTargetable? {
        let array = getFriends()
        
        if let first = array.first, first.distance <= self.statRange {
            return first
        }
        return nil
    }
    
    public func sideGetFriendsInRange() -> [SpriteTargetable] {
        var array = getFriends()
        
        array = array.filter { element -> Bool in
            return element.distance <= self.statRange
        }
        return array
    }
    public func sideGetFriendsInRange(count: Int) -> ArraySlice<SpriteTargetable> {
        var array = getFriends()
        
        array = array.filter { element -> Bool in
            return element.distance <= self.statRange
        }
        if array.count < count {
            if array.count == 0 {
                return []
            }
            return array[0 ..< array.count - 1]
        }
        return array[0 ..< count]
    }
    
    public func sideGetFriend() -> SpriteTargetable? {
        let array = getFriends()
        
        if let first = array.first, first.distance <= self.statRange {
            return first
        }
        return nil
    }
    
    public func sideGetFriends() -> [SpriteTargetable] {
        return getFriends()
    }
    public func sideGetFriends(count: Int) -> ArraySlice<SpriteTargetable> {
        let array = getFriends()
        
        if array.count < count {
            if array.count == 0 {
                return []
            }
            return array[0 ..< array.count - 1]
        }
        return array[0 ..< count]
    }
    
}
