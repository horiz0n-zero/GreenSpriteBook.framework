//
//  typeUtility.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 05/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public func /(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize.init(width: lhs.width / rhs, height: lhs.height / rhs)
}

public func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint.init(x: lhs.x / rhs, y: lhs.y / rhs)
}

public func /(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize.init(width: lhs.width / rhs.width, height: lhs.height / rhs.height)
}

public func /(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint.init(x: lhs.x / rhs.x, y: lhs.y / rhs.x)
}

public func *(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize.init(width: lhs.width * rhs, height: lhs.height * rhs)
}

public func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint.init(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func *(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize.init(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
}

public func *(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint.init(x: lhs.x * rhs.x, y: lhs.y * rhs.x)
}

public func +(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize.init(width: lhs.width + rhs, height: lhs.height + rhs)
}

public func +(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint.init(x: lhs.x + rhs, y: lhs.y + rhs)
}

public func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize.init(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint.init(x: lhs.x + rhs.x, y: lhs.y + rhs.x)
}

public func -(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize.init(width: lhs.width - rhs, height: lhs.height - rhs)
}

public func -(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint.init(x: lhs.x - rhs, y: lhs.y - rhs)
}

public func -(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize.init(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint.init(x: lhs.x - rhs.x, y: lhs.y - rhs.x)
}

public extension CGPoint {
    public func center() -> CGPoint {
        return CGPoint.init(x: self.x / 2, y: self.y / 2)
    }
    
    public func randomPoint() -> CGPoint {
        
        return CGPoint(x: self.x * CGFloat.random(), y: self.y * CGFloat.random())
    }
}

public extension CGSize {
    public func center() -> CGPoint {
        return CGPoint.init(x: self.width / 2, y: self.height / 2)
    }
    
    public func randomSize() -> CGSize {
        return CGSize(width: self.width * CGFloat.random(), height: self.height * CGFloat.random())
    }
}

public extension CGFloat {
    public static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
