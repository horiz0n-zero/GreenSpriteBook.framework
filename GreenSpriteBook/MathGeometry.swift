//
//  MathGeometry.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 23/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation

public extension CGPoint {
    @inline (__always) public func distance(to: CGPoint) -> CGFloat {
        let x = self.x - to.x
        let y = self.y - to.y
        
        return (x * x + y * y).squareRoot()
    }
}
