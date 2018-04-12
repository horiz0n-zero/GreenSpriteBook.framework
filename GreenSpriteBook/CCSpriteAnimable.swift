//
//  CCSpriteAnimable.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 05/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

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
    var spriteIsLeft: Bool { get set }
    var spriteTextures: [[[SKTexture]]] { get }
}

/** load texture from a directory
 */
/// - parameter path: the full path of a directory with a `/`
/// - parameter dico: an array of 3 Int [StayCount, MoveCount, AttackCount]
public func CCSpriteAnimableLoadTexture(from path: String, dico: [Int]) -> [[[SKTexture]]] {
    var textures = [[[SKTexture]]]()
    
    for i in 0...2 {
        let stage = (i + 1) * 100
        var direction = [[SKTexture]]()
        for d in 0...4 {
            var array = [SKTexture]()
            for r in 0...dico[i] {
                let n = stage + (d * 10) + r
                
                array.append(SKTexture.init(imageNamed: path + "/\(n).png"))
            }
            direction.append(array)
        }
        textures.append(direction)
    }
    return textures
}

public extension    CCSpriteAnimable {
    
    public subscript() -> [SKTexture] {
        return self.spriteTextures[self.spriteAction.rawValue][self.spriteDirection.rawValue]
    }
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
        let frame = self.cycleInterval / TimeInterval(self[].count)
        
        self.run(SKAction.animate(with: self[], timePerFrame: frame, resize: true, restore: false))
    }
    
    public func animateWithCompletion(_ block: @escaping () -> ()) {
        let frame = self.cycleInterval / TimeInterval(self[].count)
        
        self.run(SKAction.animate(with: self[], timePerFrame: frame, resize: true, restore: false), completion: block)
    }
}






