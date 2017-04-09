//
//  Arm.swift
//  ShadowPlay
//
//  Created by Desperado on 2/25/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation

class Arm_1: Arm {
	init() {
		super.init(imgStr: "arm_1", attachPointNodes: [AttachPointNode(x: 279, y: 985, type: .body), AttachPointNode(x: 189, y: 157, type: .hand)], hp: 0, power: 0)
		postInit()
	}
	
	override func postInit() {
		super.postInit()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		postInit()
	}
}

class Arm_2: Arm {
	init() {
		super.init(imgStr: "arm_2", attachPointNodes: [AttachPointNode(x: 432, y: 896, type: .body), AttachPointNode(x: 496, y: 68, type: .hand)], hp: 0, power: 0)
		postInit()
	}
	
	override func postInit() {
		super.postInit()
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		postInit()
	}
}
