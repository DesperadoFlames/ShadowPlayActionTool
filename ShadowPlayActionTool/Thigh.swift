//
//  Thigh.swift
//  ShadowPlay
//
//  Created by Desperado on 2/25/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation

class Thigh_1: Thigh {
	init() {
		super.init(imgStr: "thigh_1", attachPointNodes: [AttachPointNode(x: 440, y: 1844, type: .body), AttachPointNode(x: 317, y: 323, type: .calf)], hp: 0, swiftness: 0)
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

class Thigh_2: Thigh {
	init() {
		super.init(imgStr: "thigh_2", attachPointNodes: [AttachPointNode(x: 439, y: 2072, type: .body), AttachPointNode(x: 328, y: 552, type: .calf)], hp: 0, swiftness: 0)
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
