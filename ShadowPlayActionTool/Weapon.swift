//
//  Weapon.swift
//  ShadowPlay
//
//  Created by Desperado on 2/7/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class WeaponPiece: PlayerCombinablePiece {
    let baseDashATK: Int
    let baseChopATK: Int
    var level: Int = 1
    
    ////////////////////////
    // Need to be changed //
    ////////////////////////
    var extraDashATK: Int = 0
    var extraChopATK: Int = 0
    
    override var type: AttachPointNode.AttachPointNodeType {
        return .weapon
    }
    
    var dashATK: Int {
        return (baseDashATK + extraDashATK) * level
    }
    var chopATK: Int {
        return (baseChopATK + extraChopATK) * level
    }
    
    init(imgStr: String, attachPointNodes: [AttachPointNode], mass: Int, baseDashATK: Int, baseChopATK: Int) {
        self.baseDashATK = baseDashATK
        self.baseChopATK = baseChopATK
        super.init(imgStr: imgStr, attachPointNodes: attachPointNodes, mass: mass)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.baseDashATK = aDecoder.decodeInteger(forKey: "baseDashATK")
        self.baseChopATK = aDecoder.decodeInteger(forKey: "baseChopATK")
        self.level = aDecoder.decodeInteger(forKey: "level")
        self.extraDashATK = aDecoder.decodeInteger(forKey: "extraDashATK")
        self.extraChopATK = aDecoder.decodeInteger(forKey: "extraChopATK")
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(baseDashATK, forKey: "baseDashATK")
        aCoder.encode(baseChopATK, forKey: "baseChopATK")
        aCoder.encode(level, forKey: "level")
        aCoder.encode(extraDashATK, forKey: "extraDashATK")
        aCoder.encode(extraChopATK, forKey: "extraChopATK")
        super.encode(with: aCoder)
    }
}

class Spear_1: WeaponPiece {
    init() {
        super.init(imgStr: "spear_1", attachPointNodes: [AttachPointNode(x: 110, y: 30, type: .auxiliary), AttachPointNode(x: 110, y: 80, type: .auxiliary)], mass: 0, baseDashATK: 0, baseChopATK: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Spear_2: WeaponPiece {
    init() {
        super.init(imgStr: "spear_2", attachPointNodes: [AttachPointNode(x: 77, y: 50, type: .auxiliary), AttachPointNode(x: 77, y: 100, type: .auxiliary), AttachPointNode(x: 45, y: 302, type: .weapon), AttachPointNode(x: 45, y: 342, type: .weapon), AttachPointNode(x: 109, y: 302, type: .weapon), AttachPointNode(x: 109, y: 342, type: .weapon)], mass: 0, baseDashATK: 0, baseChopATK: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
        AttachPointNode.pair(primaryNode: self.attachPointNodes[2], secondaryNode: self.attachPointNodes[3])
        AttachPointNode.pair(primaryNode: self.attachPointNodes[4], secondaryNode: self.attachPointNodes[5])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Spear_3: WeaponPiece {
    init() {
        super.init(imgStr: "spear_3", attachPointNodes: [AttachPointNode(x: 69, y: 28, type: .auxiliary), AttachPointNode(x: 69, y: 78, type: .auxiliary), AttachPointNode(x: 92, y: 372, type: .weapon), AttachPointNode(x: 92, y: 412, type: .weapon), AttachPointNode(x: 46, y: 372, type: .weapon), AttachPointNode(x: 46, y: 412, type: .weapon)], mass: 0, baseDashATK: 0, baseChopATK: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
        AttachPointNode.pair(primaryNode: self.attachPointNodes[2], secondaryNode: self.attachPointNodes[3])
        AttachPointNode.pair(primaryNode: self.attachPointNodes[4], secondaryNode: self.attachPointNodes[5])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Spear_4: WeaponPiece {
    init() {
        super.init(imgStr: "spear_4", attachPointNodes: [AttachPointNode(x: 104, y: 30, type: .auxiliary), AttachPointNode(x: 104, y: 80, type: .auxiliary), AttachPointNode(x: 100, y: 480, type: .weapon), AttachPointNode(x: 100, y: 560, type: .weapon)], mass: 0, baseDashATK: 0, baseChopATK: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
        AttachPointNode.pair(primaryNode: self.attachPointNodes[2], secondaryNode: self.attachPointNodes[3])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Spear_5: WeaponPiece {
    init() {
        super.init(imgStr: "spear_5", attachPointNodes: [AttachPointNode(x: 82, y: 40, type: .auxiliary), AttachPointNode(x: 82, y: 90, type: .auxiliary), AttachPointNode(x: 93, y: 334, type: .weapon), AttachPointNode(x: 93, y: 674, type: .weapon), AttachPointNode(x: 67, y: 334, type: .weapon), AttachPointNode(x: 67, y: 674, type: .weapon)], mass: 0, baseDashATK: 0, baseChopATK: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
        AttachPointNode.pair(primaryNode: self.attachPointNodes[2], secondaryNode: self.attachPointNodes[3])
        AttachPointNode.pair(primaryNode: self.attachPointNodes[4], secondaryNode: self.attachPointNodes[5])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Spear_side_1: WeaponPiece {
    init() {
        super.init(imgStr: "spear_side_1", attachPointNodes: [AttachPointNode(x: 8, y: 244, type: .weapon), AttachPointNode(x: 8, y: 584, type: .weapon)], mass: 0, baseDashATK: 0, baseChopATK: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Spear_side_2: WeaponPiece {
    init() {
        super.init(imgStr: "spear_side_2", attachPointNodes: [AttachPointNode(x: 14, y: 36, type: .weapon), AttachPointNode(x: 14, y: 76, type: .weapon)], mass: 0, baseDashATK: 0, baseChopATK: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Spear_side_3: WeaponPiece {
    init() {
        super.init(imgStr: "spear_side_3", attachPointNodes: [AttachPointNode(x: 13, y: 53, type: .weapon), AttachPointNode(x: 13, y: 93, type: .weapon)], mass: 0, baseDashATK: 0, baseChopATK: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Axe_1: WeaponPiece {
    init() {
        super.init(imgStr: "axe_1", attachPointNodes: [AttachPointNode(x: 316, y: 260, type: .weapon), AttachPointNode(x: 316, y: 340, type: .weapon), AttachPointNode(x: 316, y: 275, type: .auxiliary), AttachPointNode(x: 316, y: 325, type: .auxiliary)], mass: 0, baseDashATK: 0, baseChopATK: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
        AttachPointNode.pair(primaryNode: self.attachPointNodes[2], secondaryNode: self.attachPointNodes[3])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Axe_2: WeaponPiece {
    init() {
        super.init(imgStr: "axe_2", attachPointNodes: [AttachPointNode(x: 485, y: 330, type: .weapon), AttachPointNode(x: 485, y: 410, type: .weapon), AttachPointNode(x: 485, y: 345, type: .auxiliary), AttachPointNode(x: 485, y: 395, type: .auxiliary)], mass: 0, baseDashATK: 0, baseChopATK: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
        AttachPointNode.pair(primaryNode: self.attachPointNodes[2], secondaryNode: self.attachPointNodes[3])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Blade_1: WeaponPiece {
    init() {
        super.init(imgStr: "blade_1", attachPointNodes: [AttachPointNode(x: 246, y: 18, type: .auxiliary), AttachPointNode(x: 246, y: 68, type: .auxiliary)], mass: 0, baseDashATK: 0, baseChopATK: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Blade_2: WeaponPiece {
    init() {
        super.init(imgStr: "blade_2", attachPointNodes: [AttachPointNode(x: 92, y: 35, type: .auxiliary), AttachPointNode(x: 92, y: 85, type: .auxiliary)], mass: 0, baseDashATK: 0, baseChopATK: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Sword_1: WeaponPiece {
    init() {
        super.init(imgStr: "sword_1", attachPointNodes: [AttachPointNode(x: 91, y: 10, type: .auxiliary), AttachPointNode(x: 91, y: 60, type: .auxiliary)], mass: 0, baseDashATK: 0, baseChopATK: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Sword_2: WeaponPiece {
    init() {
        super.init(imgStr: "sword_2", attachPointNodes: [AttachPointNode(x: 78, y: 18, type: .auxiliary), AttachPointNode(x: 78, y: 68, type: .auxiliary)], mass: 0, baseDashATK: 0, baseChopATK: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}
