//
//  Hand.swift
//  ShadowPlay
//
//  Created by Desperado on 2/25/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation

class Hand_1: Hand {
	init() {
		super.init(imgStr: "hand_1", attachPointNodes: [AttachPointNode(x: 277, y: 1257, type: .arm), AttachPointNode(x: 201, y: 186, type: .auxiliary)], hp: 0, atk: 0)
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

class Hand_2: Hand {
	init() {
		super.init(imgStr: "hand_2", attachPointNodes: [AttachPointNode(x: 276, y: 1254, type: .arm), AttachPointNode(x: 305, y: 130, type: .weapon)], hp: 0, atk: 0)
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
