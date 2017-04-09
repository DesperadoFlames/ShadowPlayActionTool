//
//  SceneObjects.swift
//  ShadowPlay
//
//  Created by Desperado on 2/3/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class Background: SKSpriteNode {
    init() {
        let texture = SKTexture(imageNamed: "back_1")
        let tSize = texture.size()
        let size = tSize.width / tSize.height > bWidth / bHeight ? CGSize(width: tSize.width * bHeight / tSize.height, height: bHeight) : CGSize(width: bWidth, height: tSize.height * bWidth / tSize.width)
        super.init(texture: texture, color: .clear, size: size)
        self.zPosition = -5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
