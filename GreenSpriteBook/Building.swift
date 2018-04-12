//
//  Building.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 10/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public class Building: SKSpriteNode, SpriteStat, SpriteCycle {
    public var life: Int {
        didSet {
            if self.life <= 0 && self.cycleDie == false {
                self.cycleDie = true
                if self.cycleInterval == 0, let die = self.cycleWorkDie {
                    die()
                }
            }
        }
    }
    public var attack: Int
    
    public var cycleDie: Bool = false
    public var cycleWork: (() -> ())? = nil
    public var cycleWorkDie: (() -> ())? = nil
    public var cycleInterval: TimeInterval = 0
    
    public init(texture: SKTexture, life: Int, attack: Int = 0, scale: CGFloat = 1.0) {
        self.life = life
        self.attack = attack
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.xScale = scale
        self.yScale = scale
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension Building {
    /// bases textures in order :
    /// - 0 GreenBase  1 - 3
    /// - 1 SquareBase 2 - 3
    public static let basesTextures: [[SKTexture]] = [
        [
            SKTexture.init(imageNamed: "GreenMapBase/1_1.png"),
            SKTexture.init(imageNamed: "GreenMapBase/2_2.png"),
            SKTexture.init(imageNamed: "GreenMapBase/3_3.png")
        ], [
            SKTexture.init(imageNamed: "SquareMapBase/2_2.png"),
            SKTexture.init(imageNamed: "SquareMapBase/3_3.png")
        ]
    ]
    
    public func addBase(type: Int, level: Int) {
        let base = SKSpriteNode(texture: Building.basesTextures[type][level], color: UIColor.clear,
                                size: CGSize.init(width: self.size.height * 1.37121212121212121, height: self.size.height))
        
        
        
        base.zPosition = -1
        
        self.addChild(base)
    }
}















