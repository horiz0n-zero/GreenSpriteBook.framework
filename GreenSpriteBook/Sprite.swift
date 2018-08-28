//
//  Sprite.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 20/08/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

open class Sprite: SKSpriteNode {
    
    public init(size: CGFloat = 42) {
        super.init(texture: nil, color: UIColor.green, size: .init(width: size, height: size))
    }
    public override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.color = UIColor.green
    }
    
    @inline (__always) public func distance(to: SKNode) -> CGFloat {
        return hypot(self.position.x - to.position.x, self.position.y - to.position.y)
    }
    
    @inline (__always) public func angle(to: SKNode) -> CGFloat {
        return atan2(self.position.y - to.position.y, self.position.x - to.position.x)
    }
    
    @inline (__always) public func distance(to: CGPoint) -> CGFloat {
        return hypot(self.position.x - to.x, self.position.y - to.y)
    }
    
    @inline (__always) public func angle(to: CGPoint) -> CGFloat {
        return atan2(self.position.y - to.y, self.position.x - to.x)
    }
    
}
