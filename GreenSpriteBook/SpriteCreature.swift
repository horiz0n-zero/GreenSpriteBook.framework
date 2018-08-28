//
//  SpriteCreature.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 20/08/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

open class SpriteCreature: Sprite, SpriteCycle, SpriteCCAnimable, SpriteStat, SpriteSide {
    public var cycleInterval: TimeInterval
    public var cycleWork: (() -> ())!
    public var cycleWorkDie: (() -> ())? = nil
    public var cycleDead: Bool = false
    
    public var ccAnimableAction: SpriteCCAnimableAction = .stay
    public var ccAnimableDirection: SpriteCCAnimableDirection = .down
    public var ccTextures: SpriteCCAnimableTexture
    public var ccIsLeft: Bool = false
    
    public var statLife: CGFloat! {
        didSet {
            if self.statLife <= 0 && !self.cycleDead {
                self.cycleDead = true
                self.sideable.sideableContainer.remove(self)
            }
        }
    }
    public typealias BaseType = SpriteCreatureIndex
    public var statAttack: CGFloat!
    public var statMove: CGFloat!
    public var statRange: CGFloat!
    public var statBase: SpriteStatBase
    public var statBaseType: SpriteStatIndex
    public var statLevel: Int
    
    public var sideable: SpriteSideable
    public var side: SpriteSideableContainer.SideType
    
    public init(base: SpriteStatBase, sideable: SpriteSideable, side: SpriteSideableContainer.SideType, level: Int = 1) {
        let textures = SpriteCreature.texturesGet(type: base.type.creature)
        
        self.statBase = base
        self.statBaseType = base.type
        self.statLevel = level
        self.cycleInterval = base.cycleInterval
        self.ccTextures = textures
        self.sideable = sideable
        self.side = side
        super.init(texture: textures[0][0][0], color: UIColor.clear, size: textures[0][0][0].size())
        base.calculate(self)
        self.sideable.sideableContainer.append(self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    deinit {
        print("creature deinit !")
    }
}

public enum      SpriteCreatureIndex: Int, SpriteStatIndex {
    case ballonLugubre = 0
    case epeiste = 1
    case ange = 2
    case anubis = 3
    case anubisEvo = 4
    case anubisShiny = 5
    case tireuseDelite = 6
    case ladyLeo = 7
    case ladyLeoEvo = 8
    case demoniste = 9
    case demonisteEvo = 10
    case athena = 11
    case athenaEvo = 12
    case arcAnge = 13
    case arcAngeEvo = 14
    case demon = 15
    case sucreDorge = 16
    case sucreDorgeEvo = 17
    case ninja = 18
    case ninjaEvo = 19
    case darkArcAnge = 20
    case darkArcAngeEvo = 21
    case roiFantome = 22
    case roiFantomeEvo = 23
    case roiFantomeShiny = 24
    case chevalier = 25
    case chevalierEvo = 26
    case chevalierShiny = 27
    case skeletica = 28
    case skeleticaEvo = 29
    case skeleticaShiny = 30
    case diaboluc = 31
    case diabolucEvo = 32
    case diabolucDemon = 33
    case diabolucDemonEvo = 34
    case diabolucShiny = 35
    case diabolucDemonShiny = 36
    case voltanica = 37
    case voltanicaEvo = 38
    case voltanicaShiny = 39
    case roseMortelle = 40
    case roseMortelleEvo = 41
    case roseMortelleShiny = 42
    case roseMortelleShinyTroop = 43
    case cyclope = 44
    case nain = 45
    case nainRare = 46
    case nainEpic = 47
    case dryade = 48
    case cerf = 49
    case destructeur = 50
    case destructeurEvo = 51
    case mechtessa = 52
    case mechtessaEvo = 53
    case mechtessaShiny = 54
    case ent = 55
    case entRare = 56
    case entEpic = 57
    case dragax = 58
    case dragaxEvo = 59
    case spirit = 60
    case spiritEvo = 61
    case spirita = 62
    case spiritaEvo = 63
    case dragon = 64
    case dragonRare = 65
    case dragonEpic = 66
    case sorcier = 67
    case sorcierRare = 68
    case sorcierEpic = 69
    case chickaboom = 70
    case horsePet = 71
    case purrsalo = 72
    case citrouille = 73
    case citrouilleEvo = 74
    case strange = 75
    case strangeRare = 76
    case strangeEpic = 77
    case treantor = 78
    case treantorEvo = 79
    case boureau = 80
    case goblinRouge = 81
    case griffon = 82
    case griffonRare = 83
    case griffonEpic = 84
    case demonDesGlaces = 85
    case champion = 86
    case championEvo = 87
    case helico = 88
    case helicoRare = 89
    case helicoShiny = 90
    case paladin = 91
    case paladinEvo = 92
    case pixie = 93
    case pixieEvo = 94
    case papillon = 95
    case archer = 96
    case archerRare = 97
    case archerEpic = 98
    case fenix = 99
    case epeisteDeFeu = 100
    case artica = 101
    case articaEvo = 102
    case articaShiny = 103
    case creation = 104
    case creationEvo = 105
    case dino = 106
    case dinoRare = 107
    case dinoEpic = 108
    case dieuDuTonerre = 109
    case dieuDuTonerreEvo = 110
    case alchimiste = 111
    case lolita = 112
    case lolitaEvo = 113
    case lolitaShiny = 114
    case bird = 115
    case birdEvo = 116
    case chasseuseDeCoeur = 117
    case chasseuseDeCoeurEvo = 118
    case tromblon = 119
    case tromblonRare = 120
    case tromblonEpic = 121
    case orc = 122
    case orcRare = 123
    case orcEpic = 124
    case sirenia = 125
    case sireniaEvo = 126
    case meduse = 127
    case meduseEvo = 128
    case meduseShiny = 129
    case succube = 130
    case succubeEvo = 131
    case reineSerpent = 132
    case ducCitrouille = 133
    case ducCitrouilleEvo = 134
    case ducCitrouilleShiny = 135
    case ducilia = 136
    case duciliaEvo = 137
    case duciliaShiny = 138
    case reineHarpie = 139
    case reineHarpieEvo = 140
    case assasin = 141
    case minotaur = 142
    case minotaurEvo = 143
    case minotaurShiny = 144
    case goblin = 145
    case hibou = 146
    case panda = 147
    case petitAnge = 148
    case petitDemon = 149
    case petitDragon = 150
    case bubule = 151
    case maraudeur = 152
    case citrouilleShiny = 153
    case cupid = 154
    case cupidEvo = 155
    case cupidShiny = 156
    case boss = 157
    case bossMega = 158
    case valentina = 159
    case valentinaEvo = 160
    case valentinaShiny = 161
    case goutteGlacer = 162
    case goutteGlacerEvo = 163
    case goutteGlacerShiny = 164
    case tritton = 165
    case rhino = 166
    case rhinoEvo = 167
    case rhinorc = 168
    case rhinorcEvo = 169
    case sorciereDeGivre = 170
    case samourai = 171
    case samouraiEvo = 172
    case samouraiShiny = 173
    case pereNoel = 174
    case pereNoelEvo = 175
    case pereNoelShiny = 176
    case dumbo = 177
    case cirina = 178
    case cirinaEvo = 179
    case ghoulem = 180
    case ghoulemEvo = 181
    case ghoulemShiny = 182
    case orksban = 183
    case orksbanEvo = 184
    case dompteur = 185
    case dompteurEvo = 186
    case faucheur = 187
    case faucheurEvo = 188
    case chevalierDeLaMort = 189
    case chevalierDeLaMortEvo = 190
    case skeletaur = 191
    case skeletaurEvo = 192
    case skeletaurShiny = 193
    case wandigo = 194
    case wandigoEvo = 195
    case soldat = 196
    case soldatRare = 197
    case soldatEpic = 198
    case moltanica = 199
    case moltanicaEvo = 200
    case moltanicaShiny = 201
    case colline = 202
    case bete = 203
    case tree = 204
    case treeRare = 205
    case treeEpic = 206
    case loupGarou = 207
    case epeisteTranchante = 208
    case immortep = 209
    case immortepEvo = 210
    case shaman = 211
    case wallaWalla = 212
    case wallaWallaEvo = 213
    case atlanticore = 214
    case atlanticoreEvo = 215
    case bouleDeNeige = 216
    case bouleDeNeigeEvo = 217
    case vlad = 218
    case vladEvo = 219
    case vladShiny = 220
    case cyclopis = 221
    case mageSpirituel = 222
    case mageSpirituelEvo = 223
    case belier = 224
    case belierEvo = 225
    case belierShiny = 226
    case druid = 227
    case druidEvo = 228
    case ingenieur = 229
    case bombe = 230
    case beteEvo = 231
    case demonisteShiny = 232
    case athenaShiny = 233
    case frosties = 234
    case tornado = 235
    case tornadoEvo = 236
    case arcAngeShiny = 237
    case darkArcAngeShiny = 238
    case grenouille = 239
    case grenouilleEvo = 240
    case azura = 241
    case azuraEvo = 242
    case wandigoShiny = 243
    case creationShiny = 244
    case mahatma = 245
    case mahatmaEvo = 246
    case wallaShiny = 247
    case professeurGrenouille = 248
    case professeurGrenouilleEvo = 249
    case chasseuseDeCoeurShiny = 250
    case birdShiny = 251
    case lavanica = 252
    case lavanicaBrulant = 253
    case lavanicaEvo = 254
    case lavanicaEvoBrulant = 255
}

public extension SpriteStatIndex {
    var creature: SpriteCreatureIndex {
        return self as! SpriteCreatureIndex
    }
}

public extension SpriteCreature {
    
    fileprivate static var textures: [SpriteCreatureIndex : (atlas: SKTextureAtlas, textures: SpriteCCAnimableTexture)] = [:]
    
    fileprivate class func texturesGet(type: SpriteCreatureIndex) -> SpriteCCAnimableTexture {
        if let textures = SpriteCreature.textures[type] {
            return textures.textures
        }
        SpriteCreature.texturesCharge(type: type)
        guard let textures = SpriteCreature.textures[type] else {
            fatalError("no texture atlas " + type.associatedData.folder)
        }
        
        return textures.textures
    }
    
    /// remove and charge new texture
    public class func texturesCharge(types: [SpriteCreatureIndex]) {
        SpriteCreature.textures.removeAll()
        for type in types {
            if SpriteCreature.textures[type] != nil {
                continue
            }
            SpriteCreature.texturesCharge(type: type)
        }
    }
    
    /// append and charge texture
    public class func texturesCharge(type: SpriteCreatureIndex) {
        var textures = SpriteCCAnimableTexture()
        let creatureTextureData = type.associatedData
        let atlas = SKTextureAtlas.init(named: creatureTextureData.folder)
        let node = SKSpriteNode()
        
        for i in 0...2 {
            let stage = (i + 1) * 100
            var direction = [[SKTexture]]()
            
            for d in 0...4 {
                var array = [SKTexture]()
                
                for r in 0...creatureTextureData.indexs[i] {
                    let n = stage + (d * 10) + r
                    let texture = atlas.textureNamed("\(n).png")
                    
                    node.texture = texture // force loading into memory
                    array.append(texture)
                }
                direction.append(array)
            }
            textures.append(direction)
        }
        SpriteCreature.textures[type] = (atlas, textures)
    }
    
}
