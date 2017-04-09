//
//  Calf.swift
//  ShadowPlay
//
//  Created by Desperado on 2/25/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation

class Calf_1: Calf {
	init() {
		super.init(imgStr: "calf_1", attachPointNodes: [AttachPointNode(x: 215, y: 1657, type: .thigh), AttachPointNode(x: 352, y: 39, type: .foot)], hp: 0)
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

class Calf_2: Calf {
	init() {
		super.init(imgStr: "calf_2", attachPointNodes: [AttachPointNode(x: 315, y: 1663, type: .foot), AttachPointNode(x: 351, y: 55, type: .thigh)], hp: 0)
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
