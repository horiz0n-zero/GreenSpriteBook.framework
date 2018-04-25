//
//  CCSpriteAnimable.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 05/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public typealias CCSpriteAnimableTexture = [[[SKTexture]]]
public typealias CCSpriteAnimableTextureArray = [CCSpriteAnimableTexture]

/// a castle clash sprite action : stay, move or attack
public enum     CCSpriteAction: Int {
    case stay = 0
    case move = 1
    case attack = 2
    
    public mutating func random() {
        self = CCSpriteAction(rawValue: Int(arc4random_uniform(3)))!
    }
}

/// a castle clash sprite direction : up, face_up, face, down_face and face.
public enum     CCSpriteDirection: Int {
    case down = 0
    case down_face = 1
    case face = 2
    case face_up = 3
    case up = 4
    
    public mutating func random() {
        self = CCSpriteDirection(rawValue: Int(arc4random_uniform(5)))!
    }
}

/// provide suport for using castle clash sprite texture
public protocol CCSpriteAnimable {
    var spriteAction: CCSpriteAction { get set }
    var spriteDirection: CCSpriteDirection { get set }
    var spriteTextures: CCSpriteAnimableTexture { get set }
    var spriteIsLeft: Bool { get set }
}

public extension    CCSpriteAnimable where Self: SKNode {
    public mutating func direction(on: SKNode) {
        let angle = atan2(self.position.y - on.position.y, self.position.x - on.position.x)
        
        func getDirection() {
            switch angle {
            case -0.25 ... 0.25:
                self.spriteDirection = .face
            case 0.25 ... 1.25:
                self.spriteDirection = .down_face
            case 1.25 ... 1.75:
                self.spriteDirection = .down
            case 1.75 ... 2.75:
                self.spriteDirection = .down_face
            case 2.75 ... 3:
                self.spriteDirection = .face
            case -3 ... -2.75:
                self.spriteDirection = .face
            case -2.75 ... -1.75:
                self.spriteDirection = .face_up
            case -1.75 ... -1.25:
                self.spriteDirection = .up
            case -1.25 ... -0.25:
                self.spriteDirection = .face_up
            default:
                self.spriteDirection = .face
            }
        }
        
        switch angle {
        case -1.5 ... 1.5:
            if self.spriteIsLeft == false {
                self.spriteIsLeft = true
                self.xScale *= -1
            }
            getDirection()
        default:
            if self.spriteIsLeft == true {
                self.spriteIsLeft = false
                self.xScale *= -1
            }
            getDirection()
        }
    }
    
    public mutating func direction(at position: CGPoint) {
        let angle = atan2(self.position.y - position.y, self.position.x - position.x)
        
        func getDirection() {
            switch angle {
            case -0.25 ... 0.25:
                self.spriteDirection = .face
            case 0.25 ... 1.25:
                self.spriteDirection = .down_face
            case 1.25 ... 1.75:
                self.spriteDirection = .down
            case 1.75 ... 2.75:
                self.spriteDirection = .down_face
            case 2.75 ... 3:
                self.spriteDirection = .face
            case -3 ... -2.75:
                self.spriteDirection = .face
            case -2.75 ... -1.75:
                self.spriteDirection = .face_up
            case -1.75 ... -1.25:
                self.spriteDirection = .up
            case -1.25 ... -0.25:
                self.spriteDirection = .face_up
            default:
                self.spriteDirection = .face
            }
        }
        
        switch angle {
        case -1.5 ... 1.5:
            if self.spriteIsLeft == false {
                self.spriteIsLeft = true
                self.xScale *= -1
            }
            getDirection()
        default:
            if self.spriteIsLeft == true {
                self.spriteIsLeft = false
                self.xScale *= -1
            }
            getDirection()
        }
    }

    
}

public extension    CCSpriteAnimable where Self: SKSpriteNode, Self: SpriteCycle {
    
    public func animate() {
        let tex = self.spriteTextures[self.spriteAction.rawValue][self.spriteDirection.rawValue]
        let frame = self.cycleInterval / TimeInterval(tex.count)
        
        self.run(SKAction.animate(with: tex,
                                  timePerFrame: frame, resize: true, restore: false))
    }
    
    public func animateWithCompletion(_ block: @escaping () -> ()) {
        let tex = self.spriteTextures[self.spriteAction.rawValue][self.spriteDirection.rawValue]
        let frame = self.cycleInterval / TimeInterval(tex.count)
        
        self.run(SKAction.animate(with: tex, timePerFrame: frame, resize: true, restore: false), completion: block)
    }
}






