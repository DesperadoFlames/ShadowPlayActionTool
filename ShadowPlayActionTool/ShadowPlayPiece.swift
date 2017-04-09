//
//  ShadowPlayPiece.swift
//  ShadowPlay
//
//  Created by Desperado on 2/3/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class ShadowPlayPiece: SKSpriteNode {
    var apnDistances: [APNDistance] = []
    let attachPointNodes: [AttachPointNode]
    let mass: Int
    
    var type: AttachPointNode.AttachPointNodeType {
        return .preset
    }
    
    init(imgStr: String, attachPointNodes: [AttachPointNode], mass: Int) {
        self.attachPointNodes = attachPointNodes
        self.mass = mass
        let texture = SKTexture(imageNamed: imgStr)
        super.init(texture: texture, color: .clear, size: texture.size())
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        self.addChildren(attachPointNodes)
        for apn in self.attachPointNodes {
            apn.reanchor()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.attachPointNodes = aDecoder.decodeObject(forKey: "APNs") as! [AttachPointNode]
        self.mass = aDecoder.decodeInteger(forKey: "mass")
        super.init(coder: aDecoder)
        postInit()
    }
    
    func canAttachTo(other: ShadowPlayPiece) -> Bool {
        let selfAttachableNodes = self.attachPointNodes.filter { (apn: AttachPointNode) -> Bool in
            return apn.type == other.type
        }
        let otherAttachableNodes = other.attachPointNodes.filter { (apn: AttachPointNode) -> Bool in
            return apn.type == self.type
        }
        for selfNode in selfAttachableNodes {
            for otherNode in otherAttachableNodes {
                if selfNode.canAttach(to: otherNode) {
                    return true
                }
            }
        }
        return false
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(attachPointNodes, forKey: "APNs")
        aCoder.encode(mass, forKey: "mass")
        super.encode(with: aCoder)
    }
    
    override func addChild(_ node: SKNode) {
        if node.parent == self {
            return
        }
        super.addChild(node)
    }
}
