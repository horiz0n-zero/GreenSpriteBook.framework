//
//  Creature.swift
//  GreenSpriteBook
//
//  Created by Antoine FeuFeu on 05/04/2018.
//  Copyright © 2018 Antoine FeuFeu. All rights reserved.
//

import Foundation
import SpriteKit

/// a prototype creature
public class Creature: SKSpriteNode, SpriteCycle, CCSpriteAnimable, SpriteStat {
    public var cycleDie: Bool = false
    public var cycleWork: (() -> ())? = nil
    public var cycleWorkDie: (() -> ())? = nil
    public var cycleInterval: TimeInterval
    
    public var spriteAction: CCSpriteAction = .stay
    public var spriteDirection: CCSpriteDirection = .down
    public var spriteIsLeft: Bool = true
    public var spriteTextures: CCSpriteAnimableTexture
    
    public var life: Int {
        didSet {
            if self.life <= 0 && self.cycleDie == false {
                self.cycleDie = true
            }
        }
    }
    public var attack: Int
    
    public init(data: CreatureData, scale: CGFloat = 1.0) {
        self.spriteTextures = CreatureTextures.textures![data.type.rawValue]
        self.life = data.life
        self.attack = data.attack
        self.cycleInterval = data.cycleInterval
        
        let texture = spriteTextures.first!.first!.first!
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.xScale = scale
        self.yScale = scale
    }
    
    deinit {
        print("deinit called")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}

/// `required` data for creature init
public struct CreatureData {
    public var cycleInterval: TimeInterval
    public var life: Int
    public var attack: Int
    public var type: CreatureTexturesIndex
    
    static public let zero = CreatureData(cycleInterval: 1, life: 0, attack: 0)
    
    public init(cycleInterval: TimeInterval, life: Int, attack: Int, type: CreatureTexturesIndex = .atlanticoreEvo) {
        self.cycleInterval = cycleInterval
        self.life = life
        self.attack = attack
        self.type = type
    }
    
}

public enum      CreatureTexturesIndex: Int {
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
}

public struct    CreatureTextures {
    
    static public var textures: CCSpriteAnimableTextureArray? = nil
    static fileprivate var texturesAtlas: [SKTextureAtlas]? = nil
    static public let texturesData: [(String, [Int])] = [
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
        ("swxiong_1", [7, 5, 7]),
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
        ("engineer_0", [7, 5, 5])
    ]
    
    public init() {
        
        CreatureTextures.textures = CCSpriteAnimableTextureArray()
        CreatureTextures.texturesAtlas = [SKTextureAtlas]()
        
        for data in CreatureTextures.texturesData {
            var textures = CCSpriteAnimableTexture()
            let atlas = SKTextureAtlas(named: data.0)
            print("atlas for ", data.0)
            
            for i in 0...2 {
                let stage = (i + 1) * 100
                var direction = [[SKTexture]]()
                
                for d in 0...4 {
                    var array = [SKTexture]()
                    
                    for r in 0...data.1[i] {
                        let n = stage + (d * 10) + r
                        
                        array.append(atlas.textureNamed("\(n).png"))
                    }
                    direction.append(array)
                }
                textures.append(direction)
            }
            
            CreatureTextures.textures!.append(textures)
            CreatureTextures.texturesAtlas!.append(atlas)
        }
        
    }
    
}
