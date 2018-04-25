//
//  Hero.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 23/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public class Hero: Creature {
    
    public override init(data: CreatureData, scale: CGFloat) {
        super.init(data: data, scale: scale)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
