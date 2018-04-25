//
//  GoldStorage.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 10/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

/// required GoldStorage texture folder
public class GoldStorage: Building {
    public var level: Int
    public var gold: Int {
        didSet {
            self.changeGoldFont()
        }
    }
    static public let textures: [SKTexture] = [
        SKTexture.init(imageNamed: "GoldStorage/1.png"),
        SKTexture.init(imageNamed: "GoldStorage/2.png")
    ]
    static public let capacities: [Int] = [
        100, 200
    ]
    static public let texturesFill: [SKTexture] = [
        SKTexture.init(imageNamed: "GoldStorage/A.png"),
        SKTexture.init(imageNamed: "GoldStorage/B.png"),
        SKTexture.init(imageNamed: "GoldStorage/C.png")
    ]
    
    public init(life: Int, attack: Int = 0, scale: CGFloat = 1.0, level: Int = 0, gold: Int = 0) {
        self.level = level
        self.gold = gold
        super.init(texture: GoldStorage.textures[level], life: life, attack: attack, scale: scale)
        let goldFont = SKSpriteNode(texture: nil, color: UIColor.clear, size: GoldStorage.texturesFill.first!.size())
        
        goldFont.name = "font"
        goldFont.position.y -= self.size.height / 8
        goldFont.anchorPoint = CGPoint(x: 0.5, y: 0)
        goldFont.zPosition = 1
        self.addChild(goldFont)
        self.changeGoldFont()
    }
    
    fileprivate func changeGoldFont() {
        guard let font = self.childNode(withName: "font") as? SKSpriteNode else {
            return
        }
        
        if self.gold != 0 {
            let n = CGFloat(self.gold) / CGFloat(GoldStorage.capacities[self.level])
            
            switch n {
            case 0...0.33:
                font.texture = GoldStorage.texturesFill[0]
            case 0.33...0.66:
                font.texture = GoldStorage.texturesFill[1]
            default:
                font.texture = GoldStorage.texturesFill[2]
            }
        }
        else {
            font.texture = nil
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
