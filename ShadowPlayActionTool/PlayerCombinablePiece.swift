//
//  PlayerCombinablePiece.swift
//  ShadowPlay
//
//  Created by Desperado on 2/14/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class PlayerCombinablePiece: ShadowPlayPiece {
    
    override init(imgStr: String, attachPointNodes: [AttachPointNode], mass: Int) {
        super.init(imgStr: imgStr, attachPointNodes: attachPointNodes, mass: mass)
        postInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        hideAllAPNs()
    }
    
    func hideAllAPNs() {
        for apn in self.attachPointNodes {
            apn.hide()
        }
    }
    
    func showAllAPNs() {
        for apn in self.attachPointNodes {
            apn.show()
        }
    }
    
    func canAttach(to other: BagItem) -> Bool {
        if let group = other as? Weapon {
            if group.items.count == 0 {
                return true
            }
            for piece in group.items {
                if self.canAttachTo(other: piece) { return true }
            }
        }
        return false
    }
    
//    override func setScale(_ scale: CGFloat) {
//        
////        fatalError()
//    }
}
