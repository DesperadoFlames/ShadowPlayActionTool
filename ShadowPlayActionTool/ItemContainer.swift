//
//  ItemContainer.swift
//  ShadowPlay
//
//  Created by Desperado on 2/19/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class FloatingItemContainer: SKNode {
    private static var _shared: FloatingItemContainer? = nil
    static var shared: FloatingItemContainer {
        return _shared!
    }
    
    override init() {
        super.init()
        FloatingItemContainer._shared = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addChild(_ node: SKNode) {
        if self.children.count == 0 {
            super.addChild(node)
        } else {
            fatalError("There is already a child in FloatingItemContainer!")
        }
    }
}

protocol ItemContainer: AnyObject {
    func removeItem(_ item: BagItem) -> Bool
    
    func addItemToSelf() -> Bool
    
    func acceptsNode(_ item: BagItem) -> Bool
    
    var containerRect: CGRect { get }
    
    func itemFloatOnSelf()
}

extension ItemContainer {
    func acceptsNode(_ item: BagItem) -> Bool {
        let point = item.positionInNode(self as! SKNode)
        return self.containerRect.contains(point)
    }
    
    var floatingItem: Weapon {
        if FloatingItemContainer.shared.children.count == 0 {
            fatalError("There is no child in FloatingItemContainer!")
        }
        return FloatingItemContainer.shared.children[0] as! Weapon
    }
}
