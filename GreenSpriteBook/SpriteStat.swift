//
//  SpriteStat.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 05/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

/// the base stat requirement for creature and other based concept object
/// spriteStat are thread safe using modify functions
public protocol SpriteStat {
    var life: Int { get set }
    var attack: Int { get set }
}

