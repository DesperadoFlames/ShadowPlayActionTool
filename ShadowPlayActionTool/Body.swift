//
//  Body.swift
//  ShadowPlay
//
//  Created by Desperado on 2/25/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation

class Body_1: Body {
    init() {
        super.init(imgStr: "body_1", attachPointNodes: [AttachPointNode(x: 399, y: 1896, type: .head), AttachPointNode(x: 378, y: 1793, type: .arm), AttachPointNode(x: 383, y: 47, type: .thigh)], hp: 0)
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

class Body_2: Body {
	init() {
		super.init(imgStr: "body_2", attachPointNodes: [AttachPointNode(x: 528, y: 1890, type: .head), AttachPointNode(x: 512, y: 1793, type: .arm), AttachPointNode(x: 516, y: 43, type: .thigh)], hp: 0)
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
