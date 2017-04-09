//
//  DesignArea.swift
//  ShadowPlay
//
//  Created by Desperado on 2/13/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class DesignTable: Scroll, ItemContainer {
    private static var _shared: DesignTable? = nil
    static var shared: DesignTable {
        return _shared!
    }
    static let defaultWidth: CGFloat = bHeight * 0.8 - 2 * Scroll.margin
    static let defaultGroupWidth: CGFloat = 0.7 * DesignTable.defaultWidth
    
    enum DesignMode {
        case combine
        case split
        case destroy
        case mirror
    }
    
    var mode: DesignMode = .combine
    var group: Weapon = Weapon()
    let _containerRect: CGRect
    var containerRect: CGRect {
        return _containerRect
    }
    
    func splitAll() {
//        for item in self.group.items {
//            item.putToBag()
//        }
    }
    
    func removeItem(_ item: BagItem) -> Bool {
        if FloatingItemContainer.shared.children.count > 0 { return false }
        if item.parent == self {
            let pos = item.positionInNode(FloatingItemContainer.shared)
            item.removeFromParent()
            item.position = pos
            restoreGroup()
            FloatingItemContainer.shared.addChild(item)
            return true
        }
        return false
    }
    
    func addItemToSelf() -> Bool {
        if FloatingItemContainer.shared.children.count < 1 { return false }
        if self.group.addPiece(floatingItem) {
            Bag.shared.sortItems()
            Bag.shared.animateScroll(0)
        }
        return true
    }
    
    func itemFloatOnSelf() {
        if !self.floatingItem.hasActions() {
            if self.group.items.count == 0 {
                let resVal = self.floatingItem.calcScaleToDesignTable()
                self.floatingItem.scaleToVal(destScale: resVal)
            } else {
                let resVal = min(floatingItem.calcScaleToDesignTable(), DesignTable.shared.group.calcScaleToDesignTable())
                self.floatingItem.scaleToVal(destScale: resVal)
                self.group.scaleToVal(destScale: resVal)
            }
        }
        self.group.reactTo(other: floatingItem)
    }
    
    func restoreGroup() {
        self.group = Weapon()
        group.position.y = (contentWidth - contentHeight) / 2
        self.addChild(group)
        group.container = self
    }
    
    init() {
        self._containerRect = CGRect(origin: CGPoint(x: -DesignTable.defaultWidth * 0.5, y: -Bag.defaultHeight * 0.5), size: CGSize(width: DesignTable.defaultWidth, height: Bag.defaultHeight))
        super.init(width: DesignTable.defaultWidth, height: Bag.defaultHeight, isScrollable: false, isVertical: true)
        DesignTable._shared = self
        self.position.x = Bag.defaultWidth + 3 * Scroll.margin + DesignTable.defaultWidth * 0.5 - bWidth * 0.5
        restoreGroup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
