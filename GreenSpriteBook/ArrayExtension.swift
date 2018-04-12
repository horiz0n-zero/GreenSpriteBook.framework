//
//  ArrayExtension.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 06/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public extension Array {
    
    public func randomElement() -> Element? {
        let index = CGFloat(self.count) * CGFloat.random()
        
        if index == 0 && self.count == 0 {
            return nil
        }
        return self[Int(index)]
    }
    
}
