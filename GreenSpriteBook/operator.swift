//
//  operator.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 26/08/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation

public func *(lhs: CGRect, rhs: CGRect) -> CGRect {
    return CGRect.init(x: lhs.origin.x * rhs.origin.x, y: lhs.origin.y * rhs.origin.y, width: lhs.width * rhs.width, height: lhs.height * rhs.height)
}

public func *(lhs: CGRect, rhs: CGSize) -> CGRect {
    return CGRect.init(x: lhs.origin.x, y: lhs.origin.y, width: lhs.width * rhs.width, height: lhs.height * rhs.height)
}

public func *(lhs: CGRect, rhs: CGPoint) -> CGRect {
    return CGRect.init(x: lhs.origin.x * rhs.x, y: lhs.origin.y * rhs.y, width: lhs.width, height: lhs.height)
}

public func *(lhs: CGRect, rhs: CGFloat) -> CGRect {
    return CGRect.init(x: lhs.origin.x * rhs, y: lhs.origin.y * rhs, width: lhs.width * rhs, height: lhs.height * rhs)
}

public func *(lhs: CGSize, rhs: CGRect) -> CGSize {
    return CGSize.init(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
}

public func *(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize.init(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
}

public func *(lhs: CGSize, rhs: CGPoint) -> CGSize {
    return CGSize.init(width: lhs.width * rhs.x, height: lhs.height * rhs.y)
}

public func *(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize.init(width: lhs.width * rhs, height: lhs.height * rhs)
}

public func *(lhs: CGPoint, rhs: CGRect) -> CGPoint {
    return CGPoint.init(x: lhs.x * rhs.origin.x, y: lhs.y * rhs.origin.y)
}

public func *(lhs: CGPoint, rhs: CGSize) -> CGPoint {
    return CGPoint.init(x: lhs.x * rhs.width, y: lhs.y * rhs.height)
}

public func *(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint.init(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
}

public func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint.init(x: lhs.x * rhs, y: lhs.y * rhs)
}

public func /(lhs: CGRect, rhs: CGRect) -> CGRect {
    return CGRect.init(x: lhs.origin.x / rhs.origin.x, y: lhs.origin.y / rhs.origin.y, width: lhs.width / rhs.width, height: lhs.height / rhs.height)
}

public func /(lhs: CGRect, rhs: CGSize) -> CGRect {
    return CGRect.init(x: lhs.origin.x, y: lhs.origin.y, width: lhs.width / rhs.width, height: lhs.height / rhs.height)
}

public func /(lhs: CGRect, rhs: CGPoint) -> CGRect {
    return CGRect.init(x: lhs.origin.x / rhs.x, y: lhs.origin.y / rhs.y, width: lhs.width, height: lhs.height)
}

public func /(lhs: CGRect, rhs: CGFloat) -> CGRect {
    return CGRect.init(x: lhs.origin.x / rhs, y: lhs.origin.y / rhs, width: lhs.width / rhs, height: lhs.height / rhs)
}

public func /(lhs: CGSize, rhs: CGRect) -> CGSize {
    return CGSize.init(width: lhs.width / rhs.width, height: lhs.height / rhs.height)
}

public func /(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize.init(width: lhs.width / rhs.width, height: lhs.height / rhs.height)
}

public func /(lhs: CGSize, rhs: CGPoint) -> CGSize {
    return CGSize.init(width: lhs.width / rhs.x, height: lhs.height / rhs.y)
}

public func /(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize.init(width: lhs.width / rhs, height: lhs.height / rhs)
}

public func /(lhs: CGPoint, rhs: CGRect) -> CGPoint {
    return CGPoint.init(x: lhs.x / rhs.origin.x, y: lhs.y / rhs.origin.y)
}

public func /(lhs: CGPoint, rhs: CGSize) -> CGPoint {
    return CGPoint.init(x: lhs.x / rhs.width, y: lhs.y / rhs.height)
}

public func /(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint.init(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
}

public func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint.init(x: lhs.x / rhs, y: lhs.y / rhs)
}

public func +(lhs: CGRect, rhs: CGRect) -> CGRect {
    return CGRect.init(x: lhs.origin.x + rhs.origin.x, y: lhs.origin.y + rhs.origin.y, width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func +(lhs: CGRect, rhs: CGSize) -> CGRect {
    return CGRect.init(x: lhs.origin.x, y: lhs.origin.y, width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func +(lhs: CGRect, rhs: CGPoint) -> CGRect {
    return CGRect.init(x: lhs.origin.x + rhs.x, y: lhs.origin.y + rhs.y, width: lhs.width, height: lhs.height)
}

public func +(lhs: CGRect, rhs: CGFloat) -> CGRect {
    return CGRect.init(x: lhs.origin.x + rhs, y: lhs.origin.y + rhs, width: lhs.width + rhs, height: lhs.height + rhs)
}

public func +(lhs: CGSize, rhs: CGRect) -> CGSize {
    return CGSize.init(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize.init(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func +(lhs: CGSize, rhs: CGPoint) -> CGSize {
    return CGSize.init(width: lhs.width + rhs.x, height: lhs.height + rhs.y)
}

public func +(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize.init(width: lhs.width + rhs, height: lhs.height + rhs)
}

public func +(lhs: CGPoint, rhs: CGRect) -> CGPoint {
    return CGPoint.init(x: lhs.x + rhs.origin.x, y: lhs.y + rhs.origin.y)
}

public func +(lhs: CGPoint, rhs: CGSize) -> CGPoint {
    return CGPoint.init(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
}

public func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint.init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

public func +(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint.init(x: lhs.x + rhs, y: lhs.y + rhs)
}

public func -(lhs: CGRect, rhs: CGRect) -> CGRect {
    return CGRect.init(x: lhs.origin.x - rhs.origin.x, y: lhs.origin.y - rhs.origin.y, width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func -(lhs: CGRect, rhs: CGSize) -> CGRect {
    return CGRect.init(x: lhs.origin.x, y: lhs.origin.y, width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func -(lhs: CGRect, rhs: CGPoint) -> CGRect {
    return CGRect.init(x: lhs.origin.x - rhs.x, y: lhs.origin.y - rhs.y, width: lhs.width, height: lhs.height)
}

public func -(lhs: CGRect, rhs: CGFloat) -> CGRect {
    return CGRect.init(x: lhs.origin.x - rhs, y: lhs.origin.y - rhs, width: lhs.width - rhs, height: lhs.height - rhs)
}

public func -(lhs: CGSize, rhs: CGRect) -> CGSize {
    return CGSize.init(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func -(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize.init(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
}

public func -(lhs: CGSize, rhs: CGPoint) -> CGSize {
    return CGSize.init(width: lhs.width - rhs.x, height: lhs.height - rhs.y)
}

public func -(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return CGSize.init(width: lhs.width - rhs, height: lhs.height - rhs)
}

public func -(lhs: CGPoint, rhs: CGRect) -> CGPoint {
    return CGPoint.init(x: lhs.x - rhs.origin.x, y: lhs.y - rhs.origin.y)
}

public func -(lhs: CGPoint, rhs: CGSize) -> CGPoint {
    return CGPoint.init(x: lhs.x - rhs.width, y: lhs.y - rhs.height)
}

public func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint.init(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

public func -(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint.init(x: lhs.x - rhs, y: lhs.y - rhs)
}
