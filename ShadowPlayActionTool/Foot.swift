//
//  Foot.swift
//  ShadowPlay
//
//  Created by Desperado on 2/25/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation

class Foot_1: Foot {
	init() {
		super.init(imgStr: "foot_1", attachPointNodes: [AttachPointNode(x: 195, y: 233, type: .calf)], hp: 0, atk: 0)
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

class Foot_2: Foot {
	init() {
		super.init(imgStr: "foot_2", attachPointNodes: [AttachPointNode(x: 228, y: 311, type: .calf)], hp: 0, atk: 0)
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
