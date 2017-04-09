//
//  WeaponAux.swift
//  ShadowPlay
//
//  Created by Desperado on 2/8/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class WeaponAuxPiece: PlayerCombinablePiece {
    override var type: AttachPointNode.AttachPointNodeType {
        return .auxiliary
    }
}

class Rod_1: WeaponAuxPiece {
    init() {
        super.init(imgStr: "rod_1", attachPointNodes: [AttachPointNode(x: 35, y: 50, type: .hand), AttachPointNode(x: 35, y: 400, type: .hand), AttachPointNode(x: 35, y: 1350, type: .weapon), AttachPointNode(x: 35, y: 1400, type: .weapon)], mass: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[2], secondaryNode: self.attachPointNodes[3])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Rod_tail_1: WeaponAuxPiece {
    init() {
        super.init(imgStr: "rod_tail_1", attachPointNodes: [AttachPointNode(x: 41, y: 316, type: .auxiliary), AttachPointNode(x: 41, y: 366, type: .auxiliary)], mass: 0)
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

class Hold_1: WeaponAuxPiece {
    init() {
        super.init(imgStr: "hold_1", attachPointNodes: [AttachPointNode(x: 114, y: 180, type: .hand), AttachPointNode(x: 114, y: 410, type: .weapon), AttachPointNode(x: 114, y: 460, type: .weapon)], mass: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[1], secondaryNode: self.attachPointNodes[2])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}
