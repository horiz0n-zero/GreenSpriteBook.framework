//
//  Spirit.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 11/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public class Spirit: Creature {
    
    
    
    override init(data: CreatureData, textures: [[[SKTexture]]], scale: CGFloat) {
        super.init(data: data, textures: textures, scale: scale)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
