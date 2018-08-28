//
//  SpriteCCAnimable.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 20/08/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

public enum SpriteCCAnimableAction: Int {
    case stay = 0
    case move = 1
    case attack = 2
}
public enum SpriteCCAnimableDirection: Int {
    case down = 0
    case down_face = 1
    case face = 2
    case face_up = 3
    case up = 4
}
public typealias SpriteCCAnimableTexture = [[[SKTexture]]]
public typealias SpriteCCAnimableTextureArray = [SpriteCCAnimableTexture]

public protocol SpriteCCAnimable: class {
    var ccAnimableAction: SpriteCCAnimableAction { get set }
    var ccAnimableDirection: SpriteCCAnimableDirection { get set }
    var ccTextures: SpriteCCAnimableTexture { get set }
    var ccIsLeft: Bool { get set }
}

public let SpriteCCAnimableActionKey: String = "SpriteCCAnimable"
public extension SpriteCCAnimable where Self: SKSpriteNode, Self: SpriteCycle {
    
    @inline (__always) public func ccDirection(angle: CGFloat) {
        
        @inline (__always) func getDirection() {
            switch angle {
            case -0.25 ... 0.25:
                self.ccAnimableDirection = .face
            case 0.25 ... 1.25:
                self.ccAnimableDirection = .down_face
            case 1.25 ... 1.75:
                self.ccAnimableDirection = .down
            case 1.75 ... 2.75:
                self.ccAnimableDirection = .down_face
            case 2.75 ... 3:
                self.ccAnimableDirection = .face
            case -3 ... -2.75:
                self.ccAnimableDirection = .face
            case -2.75 ... -1.75:
                self.ccAnimableDirection = .face_up
            case -1.75 ... -1.25:
                self.ccAnimableDirection = .up
            case -1.25 ... -0.25:
                self.ccAnimableDirection = .face_up
            default:
                self.ccAnimableDirection = .face
            }
        }
        
        switch angle {
        case -1.5 ... 1.5:
            if self.ccIsLeft {
                self.ccIsLeft = false
                self.xScale *= -1
            }
            getDirection()
        default:
            if !self.ccIsLeft {
                self.ccIsLeft = true
                self.xScale *= -1
            }
            getDirection()
        }
    }
    
    @inline (__always) public func ccAnimate() {
        let textures = self.ccTextures[self.ccAnimableAction.rawValue][self.ccAnimableDirection.rawValue]
        let duration = self.cycleInterval / TimeInterval(textures.count)
        
        self.run(SKAction.animate(with: textures, timePerFrame: duration, resize: true, restore: false), withKey: SpriteCCAnimableActionKey)
    }
    
    @inline (__always) public func ccAnimateBreak() {
        self.removeAction(forKey: SpriteCCAnimableActionKey)
    }
}

public extension SpriteCCAnimable where Self: SpriteTarget, Self: SpriteCycle {
    
    @inline (__always) public func ccMove(to: SpriteTargetable) {
        let afterMove = to.distance - self.statMove
        
        if afterMove < 0.01 { // why ??? !!!!!!
            let percent: CGFloat = 0.1
            let newInterval = self.cycleInterval * TimeInterval(percent)
            let newMove = self.statMove * percent
            let x = (to.target.position.x - self.position.x) / to.distance
            let y = (to.target.position.y - self.position.y) / to.distance
            let newPoint = CGPoint.init(x: self.position.x + (x * newMove),
                                        y: self.position.y + (y * newMove))
            
            self.run(SKAction.move(to: newPoint, duration: newInterval)) {
                self.ccAnimateBreak()
                self.cycleBreak()
            }
        }
        else if afterMove < self.statRange {
            let diff = self.statRange - afterMove
            let percent = (self.statMove - diff) / self.statMove
            let newInterval = self.cycleInterval * TimeInterval(percent)
            let newMove = self.statMove * percent
            let x = (to.target.position.x - self.position.x) / to.distance
            let y = (to.target.position.y - self.position.y) / to.distance
            let newPoint = CGPoint.init(x: self.position.x + (x * newMove),
                                        y: self.position.y + (y * newMove))
            
            self.run(SKAction.move(to: newPoint, duration: newInterval)) {
                self.ccAnimateBreak()
                self.cycleBreak()
            }
        }
        else {
            let x = (to.target.position.x - self.position.x) / to.distance
            let y = (to.target.position.y - self.position.y) / to.distance
            let newPoint = CGPoint.init(x: self.position.x + x * self.statMove,
                                        y: self.position.y + y * self.statMove)
            
            print(self.side, "move")
            self.run(SKAction.move(to: newPoint, duration: self.cycleInterval))
        }
    }
    
    @inline (__always) public func ccMove(to: SKNode) {
        let distance = self.distance(to: to)
        let afterMove = distance - self.statMove
        
        if afterMove < self.statRange {
            let diff = self.statRange - afterMove
            let percent = (self.statMove - diff) / self.statMove
            let newInterval = self.cycleInterval * TimeInterval(percent)
            let newMove = self.statMove * percent
            let x = (to.position.x - self.position.x) / distance
            let y = (to.position.y - self.position.y) / distance
            let newPoint = CGPoint.init(x: self.position.x + (x * newMove),
                                        y: self.position.y + (y * newMove))
            
            self.run(SKAction.move(to: newPoint, duration: newInterval)) {
                self.ccAnimateBreak()
                self.cycleBreak()
            }
        }
        else {
            let x = (to.position.x - self.position.x) / distance
            let y = (to.position.y - self.position.y) / distance
            let newPoint = CGPoint.init(x: self.position.x + x * self.statMove,
                                        y: self.position.y + y * self.statMove)
            
            self.run(SKAction.move(to: newPoint, duration: self.cycleInterval))
        }
    }
    
    @inline (__always) public func ccMove(to: CGPoint) {
        let distance = self.distance(to: to)
        let afterMove = distance - self.statMove
        
        if afterMove < self.statRange {
            let diff = self.statRange - afterMove
            let percent = (self.statMove - diff) / self.statMove
            let newInterval = self.cycleInterval * TimeInterval(percent)
            let newMove = self.statMove * percent
            let x = (to.x - self.position.x) / distance
            let y = (to.y - self.position.y) / distance
            let newPoint = CGPoint.init(x: self.position.x + (x * newMove),
                                        y: self.position.y + (y * newMove))
            
            self.run(SKAction.move(to: newPoint, duration: newInterval)) {
                self.ccAnimateBreak()
                self.cycleBreak()
            }
        }
        else {
            let x = (to.x - self.position.x) / distance
            let y = (to.y - self.position.y) / distance
            let newPoint = CGPoint.init(x: self.position.x + x * self.statMove,
                                        y: self.position.y + y * self.statMove)
            
            self.run(SKAction.move(to: newPoint, duration: self.cycleInterval))
        }
    }
}

public extension SpriteCCAnimable where Self: Sprite {
    
    @inline (__always) public func ccDirection(to node: SKNode) {
        let angle = self.angle(to: node)
        
        @inline (__always) func getDirection() {
            switch angle {
            case -0.25 ... 0.25:
                self.ccAnimableDirection = .face
            case 0.25 ... 1.25:
                self.ccAnimableDirection = .down_face
            case 1.25 ... 1.75:
                self.ccAnimableDirection = .down
            case 1.75 ... 2.75:
                self.ccAnimableDirection = .down_face
            case 2.75 ... 3:
                self.ccAnimableDirection = .face
            case -3 ... -2.75:
                self.ccAnimableDirection = .face
            case -2.75 ... -1.75:
                self.ccAnimableDirection = .face_up
            case -1.75 ... -1.25:
                self.ccAnimableDirection = .up
            case -1.25 ... -0.25:
                self.ccAnimableDirection = .face_up
            default:
                self.ccAnimableDirection = .face
            }
        }
        
        switch angle {
        case -1.5 ... 1.5:
            if self.ccIsLeft {
                self.ccIsLeft = false
                self.xScale *= -1
            }
            getDirection()
        default:
            if !self.ccIsLeft {
                self.ccIsLeft = true
                self.xScale *= -1
            }
            getDirection()
        }
    }
    
    @inline (__always) public func ccDirection(to position: CGPoint) {
        let angle = self.angle(to: position)
        
        @inline (__always) func getDirection() {
            switch angle {
            case -0.25 ... 0.25:
                self.ccAnimableDirection = .face
            case 0.25 ... 1.25:
                self.ccAnimableDirection = .down_face
            case 1.25 ... 1.75:
                self.ccAnimableDirection = .down
            case 1.75 ... 2.75:
                self.ccAnimableDirection = .down_face
            case 2.75 ... 3:
                self.ccAnimableDirection = .face
            case -3 ... -2.75:
                self.ccAnimableDirection = .face
            case -2.75 ... -1.75:
                self.ccAnimableDirection = .face_up
            case -1.75 ... -1.25:
                self.ccAnimableDirection = .up
            case -1.25 ... -0.25:
                self.ccAnimableDirection = .face_up
            default:
                self.ccAnimableDirection = .face
            }
        }
        
        switch angle {
        case -1.5 ... 1.5:
            if self.ccIsLeft {
                self.ccIsLeft = false
                self.xScale *= -1
            }
            getDirection()
        default:
            if !self.ccIsLeft {
                self.ccIsLeft = true
                self.xScale *= -1
            }
            getDirection()
        }
    }
}

// MARK: SpriteCreature textures

internal extension SpriteCreatureIndex {
    internal var associatedData: (folder: String, indexs: [Int]) {
        return SpriteCreatureTexturesIndexData[self.rawValue]
    }
}
fileprivate let SpriteCreatureTexturesIndexData: [(folder: String, indexs: [Int])] = [
    ("airship_0", [7, 7, 7]),
    ("amazon_0", [5, 5, 6]),
    ("angel_0", [7, 7, 9]),
    ("anubis_0", [7, 7, 7]),
    ("anubis_1", [7, 7, 7]),
    ("anubis_2", [7, 7, 7]),
    ("anye_0", [5, 5, 7]),
    ("anyejl_0", [7, 5, 7]),
    ("anyejl_1", [7, 5, 7]),
    ("archimage_0", [7, 7, 7]),
    ("archimage_1", [7, 7, 7]),
    ("athena_0", [7, 7, 7]),
    ("athena_1", [7, 7, 7]),
    ("battleangel_0", [7, 7, 7]),
    ("battleangel_1", [7, 7, 7]),
    ("boss_0", [6, 7, 6]),
    ("chris_0", [7, 7, 7]),
    ("chris_1", [7, 7, 7]),
    ("dancer_0", [5, 5, 5]),
    ("dancer_1", [5, 5, 5]),
    ("deathangel_0", [7, 7, 7]),
    ("deathangel_1", [7, 7, 7]),
    ("deathking_0", [7, 7, 6]),
    ("deathking_1", [7, 7, 6]),
    ("deathking_2", [7, 7, 7]),
    ("deathknight_0", [7, 5, 7]),
    ("deathknight_1", [7, 5, 7]),
    ("deathknight_2", [7, 5, 7]),
    ("deathwing_0", [7, 7, 7]),
    ("deathwing_1", [7, 7, 7]),
    ("deathwing_2", [7, 7, 7]),
    ("devil_0", [7, 7, 6]),
    ("devil_1", [7, 7, 6]),
    ("devil_2", [7, 7, 7]),
    ("devil_3", [7, 7, 7]),
    ("devil_4", [7, 7, 7]),
    ("devil_5", [7, 7, 7]),
    ("doubledragon_0", [7, 7, 7]),
    ("doubledragon_1", [7, 7, 7]),
    ("doubledragon_2", [7, 7, 7]),
    ("doublegun_0", [7, 7, 7]),
    ("doublegun_1", [7, 7, 7]),
    ("doublegun_2", [7, 7, 7]),
    ("doublegunplane_2", [6, 6, 6]),
    ("duyan_0", [5, 7, 7]),
    ("dwarf_0", [1, 5, 7]),
    ("dwarf_1", [1, 5, 7]),
    ("dwarf_2", [1, 5, 7]),
    ("elfpriests_0", [5, 5, 5]),
    ("elk_0", [7, 7, 7]),
    ("emo_0", [7, 7, 7]),
    ("emo_1", [7, 7, 7]),
    ("enginegirl_0", [7, 7, 7]),
    ("enginegirl_1", [7, 7, 7]),
    ("enginegirl_2", [7, 7, 7]),
    ("ents_0", [1, 5, 5]),
    ("ents_1", [1, 5, 5]),
    ("ents_2", [1, 5, 5]),
    ("eragon_0", [7, 7, 7]),
    ("eragon_1", [7, 7, 7]),
    ("EvilDevil_0", [7, 7, 7]),
    ("EvilDevil_1", [7, 7, 7]),
    ("EvilGirl_0", [7, 7, 7]),
    ("EvilGirl_1", [7, 7, 7]),
    ("fairydragon_0", [5, 5, 5]),
    ("fairydragon_1", [5, 5, 5]),
    ("fairydragon_2", [5, 5, 5]),
    ("fashi_0", [1, 5, 5]),
    ("fashi_1", [1, 5, 5]),
    ("fashi_2", [1, 5, 5]),
    ("flychicken_0", [7, 7, 7]),
    ("flyhorse_0", [7, 7, 7]),
    ("flytiger_0", [7, 7, 7]),
    ("fnangua_0", [7, 7, 7]),
    ("fnangua_1", [7, 7, 7]),
    ("foresthunters_0", [1, 5, 5]),
    ("foresthunters_1", [1, 5, 5]),
    ("foresthunters_2", [1, 5, 5]),
    ("forestking_0", [7, 7, 7]),
    ("forestking_1", [7, 7, 7]),
    ("gladiator_0", [5, 5, 6]),
    ("goblin_0", [5, 5, 5]),
    ("griffin_0", [5, 5, 5]),
    ("griffin_1", [5, 5, 5]),
    ("griffin_2", [5, 5, 5]),
    ("hanbing_0", [5, 5, 6]),
    ("hillking_0", [5, 5, 5]),
    ("hillking_1", [5, 5, 5]),
    ("helicopter_0", [5, 5, 5]),
    ("helicopter_1", [5, 5, 5]),
    ("helicopter_2", [5, 5, 5]),
    ("hero_0", [5, 5, 5]),
    ("hero_1", [5, 5, 5]),
    ("huayao_0", [7, 7, 7]),
    ("huayao_1", [7, 7, 7]),
    ("hudie_0", [7, 7, 7]),
    ("hunter_0", [1, 5, 7]),
    ("hunter_1", [1, 5, 7]),
    ("hunter_2", [1, 5, 7]),
    ("huoniao_0", [7, 7, 7]),
    ("huonv_0", [7, 7, 7]),
    ("icedragon_0", [7, 7, 7]),
    ("icedragon_1", [7, 7, 7]),
    ("icedragon_2", [7, 7, 7]),
    ("kexueguairen_0", [7, 7, 7]),
    ("kexueguairen_1", [7, 7, 7]),
    ("konglong_0", [5, 7, 5]),
    ("konglong_1", [5, 7, 5]),
    ("konglong_2", [5, 7, 5]),
    ("leishen_0", [5, 5, 9]),
    ("leishen_1", [5, 5, 8]),
    ("lianjin_0", [5, 5, 5]),
    ("lolita_0", [7, 7, 7]),
    ("lolita_1", [7, 7, 7]),
    ("lolita_2", [7, 7, 7]),
    ("lovegbird_0", [7, 7, 7]),
    ("lovegbird_1", [7, 7, 7]),
    ("loveggirl_0", [7, 7, 7]),
    ("loveggirl_1", [7, 7, 7]),
    ("mad_0", [1, 5, 5]),
    ("mad_1", [1, 5, 5]),
    ("mad_2", [1, 5, 5]),
    ("manh_0", [1, 5, 5]),
    ("manh_1", [1, 5, 5]),
    ("manh_2", [1, 5, 5]),
    ("medusa_0", [7, 7, 7]),
    ("medusa_1", [7, 7, 7]),
    ("meidusha_0", [7, 7, 7]),
    ("meidusha_1", [7, 7, 7]),
    ("meidusha_2", [7, 7, 7]),
    ("meimo_0", [5, 7, 7]),
    ("meimo_1", [5, 7, 7]),
    ("najia_0", [5, 5, 7]),
    ("nangua_0", [5, 5, 6]),
    ("nangua_1", [5, 5, 6]),
    ("nangua_2", [7, 7, 7]),
    ("ngnw_0", [7, 7, 7]),
    ("ngnw_1", [7, 7, 7]),
    ("ngnw_2", [7, 7, 7]),
    ("niaoren_0", [7, 7, 7]),
    ("niaoren_1", [7, 7, 7]),
    ("nightkiller_0", [5, 5, 6]),
    ("niutou_0", [5, 7, 7]),
    ("niutou_1", [5, 7, 7]),
    ("niutou_2", [5, 7, 7]),
    ("nongmin_0", [1, 5, 6]),
    ("owl_0", [7, 7, 7]),
    ("panda_0", [5, 5, 5]),
    ("petangel_0", [7, 7, 7]),
    ("petdevil_0", [7, 7, 7]),
    ("petdragon_0", [7, 7, 7]),
    ("petfish_0", [7, 7, 7]),
    ("predator_0", [5, 5, 5]),
    ("pumpkin_0", [7, 7, 7]),
    ("qiubite_0", [7, 7, 7]),
    ("qiubite_1", [7, 7, 7]),
    ("qiubite_2", [7, 7, 7]),
    ("qiuzhang_0", [5, 5, 6]),
    ("qiuzhang_2", [7, 7, 7]),
    ("qrjfs_0", [7, 7, 7]),
    ("qrjfs_1", [7, 7, 7]),
    ("qrjfs_2", [7, 7, 7]),
    ("rednose_0", [7, 7, 7]),
    ("rednose_1", [7, 7, 7]),
    ("rednose_2", [7, 7, 7]),
    ("renyu_0", [5, 7, 6]),
    ("rhino_0", [7, 7, 7]),
    ("rhino_1", [7, 7, 7]),
    ("rhinoorc_0", [7, 7, 7]),
    ("rhinoorc_1", [7, 7, 7]),
    ("sage_0", [5, 5, 7]),
    ("samurai_0", [7, 7, 7]),
    ("samurai_1", [7, 7, 7]),
    ("samurai_2", [7, 7, 7]),
    ("santa_0", [7, 7, 9]),
    ("santa_1", [7, 7, 9]),
    ("santa_2", [7, 7, 9]),
    ("sddumbo_0", [7, 7, 7]),
    ("seagirl_0", [7, 7, 7]),
    ("seagirl_1", [7, 7, 7]),
    ("shixianggui_0", [7, 7, 7]),
    ("shixianggui_1", [7, 7, 7]),
    ("shixianggui_2", [7, 7, 7]),
    ("shouren_0", [7, 7, 7]),
    ("shouren_1", [7, 7, 7]),
    ("shouwang_0", [7, 7, 7]),
    ("shouwang_1", [7, 7, 7]),
    ("sishen_0", [5, 5, 7]),
    ("sishen_1", [5, 5, 7]),
    ("siwqs_0", [7, 7, 7]),
    ("siwqs_1", [7, 7, 7]),
    ("skeletonking_0", [7, 7, 7]),
    ("skeletonking_1", [7, 7, 7]),
    ("skeletonking_2", [7, 7, 7]),
    ("snowmonster_0", [7, 7, 7]),
    ("snowmonster_1", [7, 7, 7]),
    ("solider_0", [1, 5, 5]),
    ("solider_1", [1, 5, 5]),
    ("solider_2", [1, 5, 5]),
    ("stlong_0", [7, 7, 7]),
    ("stlong_1", [7, 7, 7]),
    ("stlong_2", [7, 7, 7]),
    ("stone_0", [5, 7, 5]),
    ("swxiong_0", [7, 5, 7]),
    ("treedemon_0", [1, 7, 5]),
    ("treedemon_1", [1, 7, 5]),
    ("treedemon_2", [1, 7, 7]),
    ("wolfman_0", [5, 5, 5]),
    ("wushuang_0", [5, 5, 6]),
    ("wuyao_0", [5, 5, 5]),
    ("wuyao_1", [5, 5, 5]),
    ("wuyi_0", [5, 5, 5]),
    ("wuyia_0", [7, 7, 7]),
    ("wuyia_1", [7, 7, 7]),
    ("xiezi_0", [5, 5, 6]),
    ("xiezi_1", [5, 5, 6]),
    ("xueren", [5, 7, 5]),
    ("xuren_1", [5, 7, 6]),
    ("xxg_0", [7, 7, 7]),
    ("xxg_1", [7, 7, 7]),
    ("xxg_2", [7, 7, 7]),
    ("yanmo_0", [7, 7, 7]),
    ("youling_0", [5, 5, 7]),
    ("youling_1", [5, 5, 7]),
    ("zhongjia_0", [7, 7, 7]),
    ("zhongjia_1", [7, 7, 8]),
    ("zhongjia_2", [7, 7, 7]),
    ("ziran_0", [5, 5, 5]),
    ("ziran_1", [5, 5, 5]),
    ("engineer_0", [7, 5, 5]),
    ("zhadanren_0", [0, 3, 0]), // FIXME: could be zero :/
    ("swxiong_1", [7, 5, 7]),
    ("archimage_2", [7, 7, 7]),
    ("athena_2", [7, 7, 7]),
    ("bingjingling_0", [7, 7, 7]),
    ("drumman_0", [7, 7, 7]),
    ("drumman_2", [7, 7, 7]),
    ("battleangel_2", [7, 7, 7]),
    ("battleangel_3", [7, 7, 7]),
    ("hama_0", [7, 7, 7]),
    ("hama_1", [7, 7, 7]),
    ("huanyinshoujianke_1", [7, 7, 7]),
    ("huanyinshoujianke_2", [7, 7, 7]),
    ("snowmonster_2", [7, 7, 7]),
    ("kexueguairen_2", [7, 7, 7]),
    ("wudupo_1", [7, 7, 7]),
    ("wudupo_2", [7, 7, 7]),
    ("wuyia_2", [7, 7, 7]),
    ("GirlAlchemist_0", [7, 7, 7]),
    ("GirlAlchemist_1", [7, 7, 7]),
    ("loveggirl_2", [7, 7, 7]),
    ("lovegbird_2", [7, 7, 7]),
    ("liuyuelong_0", [7, 7, 7]),
    ("liuyuelong_1", [7, 7, 7]),
    ("liuyuelong_3", [7, 7, 7]),
    ("liuyuelong_4", [7, 7, 7])
]
