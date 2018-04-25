//
//  TeslaMagicTower.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 10/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public class TeslaMagicTower: Building {
    
    static public let textures: [SKTexture] = [
        SKTexture.init(imageNamed: "MagicTower/1.png"),
        SKTexture.init(imageNamed: "MagicTower/2.png"),
        SKTexture.init(imageNamed: "MagicTower/3.png"),
        SKTexture.init(imageNamed: "MagicTower/4.png"),
        SKTexture.init(imageNamed: "MagicTower/5.png"),
        SKTexture.init(imageNamed: "MagicTower/6.png"),
        SKTexture.init(imageNamed: "MagicTower/7.png"),
        SKTexture.init(imageNamed: "MagicTower/8.png"),
        SKTexture.init(imageNamed: "MagicTower/9.png"),
        SKTexture.init(imageNamed: "MagicTower/10.png"),
        SKTexture.init(imageNamed: "MagicTower/11.png")
    ]
    /// (life, attack) default value
    static public let lifeAttack: [(Int, Int)] = [
        (100, 20),
        (200, 40),
        (500, 100),
        (750, 150),
        (1000, 200),
        (1200, 280),
        (1500, 330),
        (1750, 400),
        (2000, 500),
        (4500, 1000),
        (10_000, 2000)
    ]
    
    var level: Int
    
    public init(level: Int = 0, scale: CGFloat = 1.0) {
        self.level = level
        super.init(texture: TeslaMagicTower.textures[level],
                   life: TeslaMagicTower.lifeAttack[level].0,
                   attack: TeslaMagicTower.lifeAttack[level].1, scale: scale)
        self.cycleInterval = 2.0
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
