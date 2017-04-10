//
//  Human.swift
//  ShadowPlay
//
//  Created by Desperado on 2/28/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class Human: SKNode {
	var body: Body?
	var head: Head?
	var frontArm: Arm?
	var backArm: Arm?
	var frontHand: Hand?
	var backHand: Hand?
	var frontThigh: Thigh?
	var backThigh: Thigh?
	var frontCalf: Calf?
	var backCalf: Calf?
	var frontFoot: Foot?
	var backFoot: Foot?
	var actionSpeed: Double = 1
	
	private var _yOffset: CGFloat = 0
	var yOffset: CGFloat {
		get {
			return self._yOffset
		}
		set {
			self.position.y += newValue - _yOffset
			_yOffset = newValue
		}
	}
	
	var frontHandWeapon: Weapon? {
		willSet {
			if frontHandWeapon != nil {
				frontHandWeapon?.removeFromParent()
			}
		}
		didSet {
			if frontHandWeapon != nil {
				doubleHandedWeapon = nil
				self.frontHand?.addChild(frontHandWeapon!)
				self.frontHand?.childAnchor.zRotation = -CGFloat(Double.pi / 4 * 3)
			}
		}
	}
	var backHandWeapon: Weapon? {
		willSet {
			if backHandWeapon != nil {
				backHandWeapon?.removeFromParent()
			}
		}
		didSet {
			if backHandWeapon != nil {
				doubleHandedWeapon = nil
				self.backHand?.addChild(backHandWeapon!)
				self.backHand?.childAnchor.zRotation = -CGFloat(Double.pi / 4 * 3)
			}
		}
	}
	var doubleHandedWeapon: Weapon? {
		willSet {
			if doubleHandedWeapon != nil {
				doubleHandedWeapon?.removeFromParent()
			}
		}
		didSet {
			if doubleHandedWeapon != nil {
				frontHandWeapon = nil
				backHandWeapon = nil
				self.frontHand?.addChild(doubleHandedWeapon!)
			}
		}
	}
	
	var isValidHuman: Bool {
		return body != nil && head != nil && frontArm != nil && backArm != nil && frontHand != nil && backHand != nil && frontThigh != nil && backThigh != nil && frontCalf != nil && backCalf != nil && frontFoot != nil && backFoot != nil
	}
	
	func combine() {
		if isValidHuman {
			body!.removeFromParent()
			self.addChild(body!)
			body!.setHead(head!)
			body!.setFrontArm(frontArm!)
			body!.setBackArm(backArm!)
			body!.setFrontThigh(frontThigh!)
			body!.setBackThigh(backThigh!)
			frontArm!.setHand(frontHand!)
			backArm!.setHand(backHand!)
			frontThigh!.setCalf(frontCalf!)
			backThigh!.setCalf(backCalf!)
			frontCalf!.setFoot(frontFoot!)
			backCalf!.setFoot(backFoot!)
		}
	}
	
	init(body: Body? = nil, head: Head? = nil, arm: Arm? = nil, hand: Hand? = nil, thigh: Thigh? = nil, calf: Calf? = nil, foot: Foot? = nil) {
		self.body = body
		self.head = head
		self.frontArm = arm
		self.backArm = (arm?.copy() as? Arm?) ?? nil
		self.frontHand = hand
		self.backHand = (hand?.copy() as? Hand?) ?? nil
		self.frontThigh = thigh
		self.backThigh = (thigh?.copy() as? Thigh?) ?? nil
		self.frontCalf = calf
		self.backCalf = (calf?.copy() as? Calf?) ?? nil
		self.frontFoot = foot
		self.backFoot = (foot?.copy() as? Foot?) ?? nil
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setAction(bodyRot: CGFloat, headRot: CGFloat, frontArmRot: CGFloat, backArmRot: CGFloat, frontHandRot: CGFloat, backHandRot: CGFloat, frontThighRot: CGFloat, backThighRot: CGFloat, frontCalfRot: CGFloat, backCalfRot: CGFloat, frontFootRot: CGFloat, backFootRot: CGFloat, yOffset: CGFloat) {
		if isValidHuman {
			self.body!.zRotation = bodyRot
			self.head!.zRotation = headRot
			self.frontArm!.zRotation = frontArmRot
			self.backArm!.zRotation = backArmRot
			self.frontHand!.zRotation = frontHandRot
			self.backHand!.zRotation = backHandRot
			self.frontThigh!.zRotation = frontThighRot
			self.backThigh!.zRotation = backThighRot
			self.frontCalf!.zRotation = frontCalfRot
			self.backCalf!.zRotation = backCalfRot
			self.frontFoot!.zRotation = frontFootRot
			self.backFoot!.zRotation = backFootRot
			setWeaponTransform()
			self.yOffset = yOffset
		}
	}
	
	func setWeaponTransform() {
		if self.doubleHandedWeapon != nil {
            let diffVec = self.backHand!.attachPointNodes[1].positionInNode(self.body!) - self.frontHand!.attachPointNodes[1].positionInNode(self.body!)
            let atanVal = atan2(diffVec.y, diffVec.x)
            if atanVal > 0 {
                self.frontHand?.childAnchor.position = self.backHand!.attachPointNodes[1].position + CGPoint(x: 200, y: 400)
            } else {
                self.frontHand?.childAnchor.position = self.backHand!.attachPointNodes[1].position - CGPoint(x: 200, y: 400)
            }
			self.frontHand?.childAnchor.zRotation = atanVal - self.frontHand!.absoluteZRotation - CGFloat(Double.pi / 2)
        } else {
            self.frontHand?.childAnchor.position = self.backHand!.attachPointNodes[1].position + CGPoint(x: 300, y: 100)
        }
	}
	
	func toAction(bodyRot: CGFloat, headRot: CGFloat, frontArmRot: CGFloat, backArmRot: CGFloat, frontHandRot: CGFloat, backHandRot: CGFloat, frontThighRot: CGFloat, backThighRot: CGFloat, frontCalfRot: CGFloat, backCalfRot: CGFloat, frontFootRot: CGFloat, backFootRot: CGFloat, yOffset: CGFloat, dur: TimeInterval, anchorIsFrontFoot: Bool) {
		if isValidHuman {
			if dur == 0 {
				self.setAction(bodyRot: bodyRot, headRot: headRot, frontArmRot: frontArmRot, backArmRot: backArmRot, frontHandRot: frontHandRot, backHandRot: backHandRot, frontThighRot: frontThighRot, backThighRot: backThighRot, frontCalfRot: frontCalfRot, backCalfRot: backCalfRot, frontFootRot: frontFootRot, backFootRot: backFootRot, yOffset: yOffset)
				return
			}
			let bodyRot_ori = self.body!.zRotation
			let headRot_ori = self.head!.zRotation
			let frontArmRot_ori = self.frontArm!.zRotation
			let backArmRot_ori = self.backArm!.zRotation
			let frontHandRot_ori = self.frontHand!.zRotation
			let backHandRot_ori = self.backHand!.zRotation
			let frontThighRot_ori = self.frontThigh!.zRotation
			let backThighRot_ori = self.backThigh!.zRotation
			let frontCalfRot_ori = self.frontCalf!.zRotation
			let backCalfRot_ori = self.backCalf!.zRotation
			let frontFootRot_ori = self.frontFoot!.zRotation
			let backFootRot_ori = self.backFoot!.zRotation
			let yOffset_ori = self.yOffset
			let latterFootTip = anchorIsFrontFoot ? self.frontFoot!.tip : self.backFoot!.tip
			let latterFootTipPosX = latterFootTip.positionInNode(self.parent!).x
			let ab: AnimationBlock = {_, value in
				let val = value / CGFloat(dur)
				let oneMinusVal = 1 - val
				self.setAction(bodyRot: bodyRot_ori * oneMinusVal + bodyRot * val, headRot: headRot_ori * oneMinusVal + headRot * val, frontArmRot: frontArmRot_ori * oneMinusVal + frontArmRot * val, backArmRot: backArmRot_ori * oneMinusVal + backArmRot * val, frontHandRot: frontHandRot_ori * oneMinusVal + frontHandRot * val, backHandRot: backHandRot_ori * oneMinusVal + backHandRot * val, frontThighRot: frontThighRot_ori * oneMinusVal + frontThighRot * val, backThighRot: backThighRot_ori * oneMinusVal + backThighRot * val, frontCalfRot: frontCalfRot_ori * oneMinusVal + frontCalfRot * val, backCalfRot: backCalfRot_ori * oneMinusVal + backCalfRot * val, frontFootRot: frontFootRot_ori * oneMinusVal + frontFootRot * val, backFootRot: backFootRot_ori * oneMinusVal + backFootRot * val, yOffset: yOffset_ori * oneMinusVal + yOffset * val)
				self.position.x -= latterFootTip.positionInNode(self.parent!).x - latterFootTipPosX
			}
			let action = SKAction.customAction(withDuration: dur, actionBlock: ab)
			self.run(action)
		}
	}
	
	func toAction(_ actionPoint: [CGFloat], dur: TimeInterval, anchorIsFrontFoot: Bool) {
		self.toAction(bodyRot: actionPoint[1], headRot: actionPoint[0], frontArmRot: actionPoint[2], backArmRot: actionPoint[4], frontHandRot: actionPoint[3], backHandRot: actionPoint[5], frontThighRot: actionPoint[6], backThighRot: actionPoint[8], frontCalfRot: actionPoint[7], backCalfRot: actionPoint[9], frontFootRot: actionPoint[10], backFootRot: actionPoint[11], yOffset: actionPoint[12], dur: dur, anchorIsFrontFoot: anchorIsFrontFoot)
	}
	
	func runAction(_ action: HumanAction, withBufferTime: TimeInterval = 0) {
		self.removeAllActions()
		var actionsToRun: [SKAction] = []
		var preActions: [SKAction] = []
		let preDur = withBufferTime / self.actionSpeed
		preActions.append(SKAction.run {
			self.toAction(action.actionPoints[0], dur: preDur, anchorIsFrontFoot: action.anchorIsFrontFoots[0])
		})
		preActions.append(SKAction.wait(forDuration: preDur))
		for i in 1..<action.actionPoints.count {
			let dur = action.durs[i-1] / self.actionSpeed
			actionsToRun.append(SKAction.run {
				self.toAction(action.actionPoints[i], dur: dur, anchorIsFrontFoot: action.anchorIsFrontFoots[i])
			})
			actionsToRun.append(SKAction.wait(forDuration: dur))
		}
		if action.shouldRepeat {
			let dur = action.durs[action.durs.count - 1] / self.actionSpeed
			actionsToRun.append(SKAction.run {
				self.toAction(action.actionPoints[0], dur: dur, anchorIsFrontFoot: action.anchorIsFrontFoots[0])
			})
			actionsToRun.append(SKAction.wait(forDuration: dur))
			self.run(SKAction.sequence([SKAction.sequence(preActions), SKAction.wait(forDuration: preDur), SKAction.repeatForever(SKAction.sequence(actionsToRun))]))
		} else {
			self.run(SKAction.sequence([SKAction.sequence(preActions), SKAction.wait(forDuration: preDur), SKAction.sequence(actionsToRun)]))
		}
	}
    
    func runAction(_ action: String, withBufferTime: TimeInterval = 0) {
        self.runAction(HumanAction.actions[action]!, withBufferTime: withBufferTime)
    }
}
