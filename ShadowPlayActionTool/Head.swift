//
//  Head.swift
//  ShadowPlay
//
//  Created by Desperado on 2/25/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation

class Head_1: Head {
    init() {
        super.init(imgStr: "head_1", attachPointNodes: [AttachPointNode(x: 256, y: 56, type: .body)], hp: 0)
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

class Head_2: Head {
	init() {
		super.init(imgStr: "head_2", attachPointNodes: [AttachPointNode(x: 318, y: 57, type: .body)], hp: 0)
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
