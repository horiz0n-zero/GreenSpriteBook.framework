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
    public var spriteTextures: [[[SKTexture]]]
    
    public var life: Int {
        didSet {
            if self.life <= 0 && self.cycleDie == false {
                self.cycleDie = true
            }
        }
    }
    public var attack: Int
    
    public init(data: CreatureData, textures: [[[SKTexture]]], scale: CGFloat = 1.0) {
        self.spriteTextures = textures
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
    
    static public let zero = CreatureData(cycleInterval: 0, life: 0, attack: 0)
    
    public init(cycleInterval: TimeInterval, life: Int, attack: Int) {
        self.cycleInterval = cycleInterval
        self.life = life
        self.attack = attack
    }
}

public enum      CreatureDataTextureIndex: Int {
    case ballonLugubre = 0
    case epeiste = 1
    case ange = 2
    case anubis = 3
    case anubisEvo = 4
    case anubisShiny = 5
    case tireuseDelite = 6
    case ladyLeo = 7
    case ladyLeoEvo = 8
    case athena = 9
    case athenaEvo = 10
    case arcAnge = 11
    case arcAngeEvo = 12
    case demon = 13
    case sucreDorge = 14
    case sucreDorgeEvo = 15
    case ninja = 16
    case ninjaEvo = 17
    case darkArcAnge = 18
    case darkArcAngeEvo = 19
    case roiFantome = 20
    case roiFantomeEvo = 21
    case roiFantomeShiny = 22
    case chevalier = 23
    case chevalierEvo = 24
    case chevalierShiny = 25
    case skeletica = 26
    case skeleticaEvo = 27
    case skeleticaShiny = 28
    case diaboluc = 29
    case diabolucEvo = 30
    case diabolucDemon = 31
    case diabolucDemonEvo = 32
    case diabolucShiny = 33
    case diabolucDemonShiny = 34
    case voltanica = 35
    case voltanicaEvo = 36
    case voltanicaShiny = 37
    case roseMortelle = 38
    case roseMortelleEvo = 39
    case roseMortelleShiny = 40
    case roseMortelleShinyTroop = 41
    case cyclope = 42
    case nain = 43
    case nainRare = 44
    case nainEpic = 45
    case dryade = 46
    case cerf = 47
    case destructeur = 48
    case destructeurEvo = 49
    case ingenieur = 50
    case mechtessa = 51
    case mechtessaEvo = 52
    case mechtessaShiny = 53
    case ent = 54
    case entRare = 55
    case entEpic = 56
    case dragax = 57
    case dragaxEvo = 58
    case spirit = 59
    case spiritEvo = 60
    case spirita = 61
    case spiritaEvo = 62
    case dragon = 63
    case dragonRare = 64
    case dragonEpic = 65
    case sorcier = 66
    case sorcierRare = 67
    case sorcierEpic = 68
    case chickaboom = 69
    case horsePet = 70
    case purrsalo = 71
    case citrouille = 72
    case citrouilleEvo = 73
    case strange = 74
    case strangeRare = 75
    case strangeEpic = 76
    case treantor = 77
    case treantorEvo = 78
    case boureau = 79
    case goblinRouge = 80
    case griffon = 81
    case griffonRare = 82
    case griffonEpic = 83
    case demonDesGlaces = 84
    case champion = 85
    case championEvo = 86
    case helico = 87
    case helicoRare = 88
    case helicoShiny = 89
    case paladin = 90
    case paladinEvo = 91
    case pixie = 92
    case pixieEvo = 93
    case papillon = 94
    case archer = 95
    case archerRare = 96
    case archerEpic = 97
    case fenix = 98
    case epeisteDeFeu = 99
    case artica = 100
    case articaEvo = 101
    case articaShiny = 102
    case creation = 103
    case creationEvo = 104
    case dino = 105
    case dinoRare = 106
    case dinoEpic = 107
    case dieuDuTonerre = 108
    case dieuDuTonerreEvo = 109
    case alchimiste = 110
    case lolita = 111
    case lolitaEvo = 112
    case lolitaShiny = 113
    case bird = 114
    case birdEvo = 115
    case chasseuseDeCoeur = 116
    case chasseuseDeCoeurEvo = 117
    case tromblon = 118
    case tromblonRare = 119
    case tromblonEpic = 120
    case orc = 121
    case orcRare = 122
    case orcEpic = 123
    case sirenia = 124
    case sireniaEvo = 125
    case meduse = 126
    case meduseEvo = 127
    case meduseShiny = 128
    case succube = 129
    case succubeEvo = 130
    case reineSerpent = 131
    case ducCitrouille = 132
    case ducCitrouilleEvo = 133
    case ducCitrouilleShiny = 134
    case ducilia = 135
    case duciliaEvo = 136
    case duciliaShiny = 137
    case reineHarpie = 138
    case reineHarpieEvo = 139
    case assasin = 140
    case minotaur = 141
    case minotaurEvo = 142
    case minotaurShiny = 143
    case goblin = 144
    case hibou = 145
    case panda = 146
    case petitAnge = 147
    case petitDemon = 148
    case petitDragon = 149
    case bubule = 150
    case maraudeur = 151
    case citrouilleShiny = 152
    case cupid = 153
    case cupidEvo = 154
    case cupidShiny = 155
    case boss = 156
    case bossMega = 157
    case valentina = 158
    case valentinaEvo = 159
    case valentinaShiny = 160
    case goutteGlacer = 161
    case goutteGlacerEvo = 162
    case goutteGlacerShiny = 163
    case tritton = 164
    case rhino = 165
    case rhinoEvo = 166
    case rhinorc = 167
    case rhinorcEvo = 168
    case sorciereDeGivre = 169
    case samourai = 170
    case samouraiEvo = 171
    case samouraiShiny = 172
    case pereNoel = 173
    case pereNoelEvo = 174
    case pereNoelShiny = 175
    case dumbo = 176
    case cirina = 177
    case cirinaEvo = 178
    case ghoulem = 179
    case ghoulemEvo = 180
    case ghoulemShiny = 181
    case orksban = 182
    case orksbanEvo = 183
    case dompteur = 184
    case dompteurEvo = 185
    case faucheur = 186
    case faucheurEvo = 187
    case chevalierDeLaMort = 188
    case chevalierDeLaMortEvo = 189
    case skeletaur = 190
    case skeletaurEvo = 191
    case skeletaurShiny = 192
    case wandigo = 193
    case wandigoEvo = 194
    case soldat = 195
    case soldatRare = 196
    case soldatEpic = 197
    case moltanica = 198
    case moltanicaEvo = 199
    case moltanicaShiny = 200
    case colline = 201
    case bete = 202
    case tree = 203
    case treeRare = 204
    case treeEpic = 205
    case loupGarou = 206
    case epeisteTranchante = 207
    case immortep = 208
    case immortepEvo = 209
    case shaman = 210
    case wallaWalla = 211
    case wallaWallaEvo = 212
    case atlanticore = 213
    case atlanticoreEvo = 214
    case bouleDeNeige = 215
    case bouleDeNeigeEvo = 216
    case vlad = 217
    case vladEvo = 218
    case vladShiny = 219
    case cyclopis = 220
    case mageSpirituel = 221
    case mageSpirituelEvo = 222
    case belier = 223
    case belierEvo = 224
    case belierShiny = 225
    case druid = 226
    case druidEvo = 227
}

public extension CreatureData {
    
    public static func getTextures() -> [[[[SKTexture]]]] {
        
        let data: [(String, [Int])] = [
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
            ("engineer_0", [7, 5, 5]),
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
            ("seagirl_0", [7, 7, 7]),
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
            ("ziran_1", [5, 5, 5])
            
        ]
        var textures: [[[[SKTexture]]]] = []
        
        for d in data {
            textures.append(CCSpriteAnimableLoadTexture(from: d.0, dico: d.1))
        }
        return textures
    }
}




