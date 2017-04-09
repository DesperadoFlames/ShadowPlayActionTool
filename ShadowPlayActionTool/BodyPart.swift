//
//  BodyPart.swift
//  ShadowPlay
//
//  Created by Desperado on 2/25/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class BodyPart: PlayerCombinablePiece {
    var maxHP: Int
    var hp: Int
    
    init(imgStr: String, attachPointNodes: [AttachPointNode], hp: Int) {
        self.hp = hp
        self.maxHP = hp
        super.init(imgStr: imgStr, attachPointNodes: attachPointNodes, mass: 0)
        postInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.hp = aDecoder.decodeInteger(forKey: "hp")
        self.maxHP = aDecoder.decodeInteger(forKey: "maxHP")
        super.init(coder: aDecoder)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        let anchorAPN = self.attachPointNodes[0]
        self.anchorPoint = CGPoint(x: anchorAPN.anchorPosX, y: anchorAPN.anchorPosY)
        _ = self.attachPointNodes.map {$0.reanchor}
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.maxHP, forKey: "maxHP")
        aCoder.encode(self.hp, forKey: "HP")
        super.encode(with: aCoder)
    }
    
    var absoluteZRotation: CGFloat {
        return self.parent is Body ? self.zRotation : self.zRotation + self.parent!.zRotation
    }
}

class Arm: BodyPart {
    var power: Int
    
    init(imgStr: String, attachPointNodes: [AttachPointNode], hp: Int, power: Int) {
        self.power = power
        super.init(imgStr: imgStr, attachPointNodes: attachPointNodes, hp: hp)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.power = aDecoder.decodeInteger(forKey: "power")
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(power, forKey: "power")
    }
    
    override var type: AttachPointNode.AttachPointNodeType {
        return .arm
    }
    
    func setHand(_ hand: Hand) {
        self.addChild(hand)
        hand.position = self.attachPointNodes[1].position
        hand.zPosition = self.zPosition + 0.5
    }
}

class Body: BodyPart {
    override var type: AttachPointNode.AttachPointNodeType {
        return .body
    }
    
    func setHead(_ head: Head) {
        self.addChild(head)
        head.position = self.attachPointNodes[0].position
        head.zPosition = self.zPosition + 1
    }
    
    func setFrontArm(_ frontArm: Arm) {
        self.addChild(frontArm)
        frontArm.position = self.attachPointNodes[1].position
        frontArm.zPosition = self.zPosition + 1
    }
    
    func setBackArm(_ backArm: Arm) {
        self.addChild(backArm)
        backArm.position = self.attachPointNodes[1].position
        backArm.zPosition = self.zPosition - 1
    }
    
    func setFrontThigh(_ frontThigh: Thigh) {
        self.addChild(frontThigh)
        frontThigh.position = self.attachPointNodes[2].position
        frontThigh.zPosition = self.zPosition + 1
    }
    
    func setBackThigh(_ backThigh: Thigh) {
        self.addChild(backThigh)
        backThigh.position = self.attachPointNodes[2].position
        backThigh.zPosition = self.zPosition - 1
    }
    
    override func postInit() {
        super.postInit()
        let anchorAPN = self.attachPointNodes[2]
        self.anchorPoint = CGPoint(x: anchorAPN.anchorPosX, y: anchorAPN.anchorPosY)
        _ = self.attachPointNodes.map {$0.reanchor}
    }
}

class Foot: BodyPart {
    var atk: Int
	let tip: SKNode = SKNode()
    
    init(imgStr: String, attachPointNodes: [AttachPointNode], hp: Int, atk: Int) {
        self.atk = atk
        super.init(imgStr: imgStr, attachPointNodes: attachPointNodes, hp: hp)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.atk = aDecoder.decodeInteger(forKey: "atk")
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(atk, forKey: "atk")
    }
	
	override func postInit() {
		super.postInit()
		tip.position = CGPoint(x: (1-self.anchorPoint.x) * self.frame.width, y: -self.anchorPoint.y * self.frame.height)
		self.addChild(tip)
	}
    
    override var type: AttachPointNode.AttachPointNodeType {
        return .foot
    }
}

class Hand: BodyPart {
    var atk: Int
    var childAnchor: SKNode = SKNode()
    
    init(imgStr: String, attachPointNodes: [AttachPointNode], hp: Int, atk: Int) {
        self.atk = atk
        super.init(imgStr: imgStr, attachPointNodes: attachPointNodes, hp: hp)
        postInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.atk = aDecoder.decodeInteger(forKey: "atk")
        super.init(coder: aDecoder)
        postInit()
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(atk, forKey: "atk")
    }
    
    override var type: AttachPointNode.AttachPointNodeType {
        return .hand
    }
    
    override func postInit() {
        super.postInit()
        self.addChild(self.childAnchor)
        childAnchor.position = self.attachPointNodes[1].position
    }
    
    override func addChild(_ node: SKNode) {
        if let weapon = node as? Weapon {
            self.childAnchor.addChild(weapon)
            weapon.position = weapon.position - weapon.primaryHandAPN!.positionInNode(self.childAnchor)
        } else {
            super.addChild(node)
        }
    }
}

class Head: BodyPart {
    override var type: AttachPointNode.AttachPointNodeType {
        return .head
    }
}

class Calf: BodyPart {
    override var type: AttachPointNode.AttachPointNodeType {
        return .calf
    }
    
    func setFoot(_ foot: Foot) {
        self.addChild(foot)
        foot.position = self.attachPointNodes[1].position
        foot.zPosition = self.zPosition + 1
    }
}

class Thigh: BodyPart {
    var swiftness: Int
    
    init(imgStr: String, attachPointNodes: [AttachPointNode], hp: Int, swiftness: Int) {
        self.swiftness = swiftness
        super.init(imgStr: imgStr, attachPointNodes: attachPointNodes, hp: hp)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.swiftness = aDecoder.decodeInteger(forKey: "swiftness")
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(swiftness, forKey: "swiftness")
        super.encode(with: aCoder)
    }
    
    override var type: AttachPointNode.AttachPointNodeType {
        return .thigh
    }
    
    func setCalf(_ calf: Calf) {
        self.addChild(calf)
        calf.position = self.attachPointNodes[1].position
        calf.zPosition = self.zPosition + 1
    }
}
