//
//  Bag.swift
//  ShadowPlay
//
//  Created by Desperado on 2/16/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class BagData: NSObject, NSCoding {
    let numUnits: Int
    let items: [BagItem]
    
    override init() {
        self.numUnits = 2
        self.items = [Weapon(Spear_1()), Weapon(Spear_2()), Weapon(Spear_3()), Weapon(Spear_4()), Weapon(Spear_5()), Weapon(Spear_side_1()), Weapon(Spear_side_1()), Weapon(Spear_side_2()), Weapon(Spear_side_2()), Weapon(Spear_side_3()), Weapon(Spear_side_3()), Weapon(Axe_1()), Weapon(Axe_2()), Weapon(Blade_1()), Weapon(Blade_2()), Weapon(Sword_1()), Weapon(Sword_2()), Weapon(Rod_1()), Weapon(Rod_1()), Weapon(Rod_1()), Weapon(Rod_1()), Weapon(Rod_1()), Weapon(Rod_tail_1()), Weapon(Hold_1()), Weapon(Hold_1()), Weapon(Hold_1()), Weapon(Hold_1()), Weapon(Hold_1())]
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.numUnits = aDecoder.decodeInteger(forKey: "numUnits")
//        self.items = aDecoder.decodeObject(forKey: "items") as! [BagItem]
        self.items = [Weapon(Spear_1()), Weapon(Spear_2()), Weapon(Spear_3()), Weapon(Spear_4()), Weapon(Spear_5()), Weapon(Spear_side_1()), Weapon(Spear_side_1()), Weapon(Spear_side_2()), Weapon(Spear_side_2()), Weapon(Spear_side_3()), Weapon(Spear_side_3()), Weapon(Axe_1()), Weapon(Axe_2()), Weapon(Blade_1()), Weapon(Blade_2()), Weapon(Sword_1()), Weapon(Sword_2()), Weapon(Rod_1()), Weapon(Rod_1()), Weapon(Rod_1()), Weapon(Rod_1()), Weapon(Rod_1()), Weapon(Rod_tail_1()), Weapon(Hold_1()), Weapon(Hold_1()), Weapon(Hold_1()), Weapon(Hold_1()), Weapon(Hold_1())]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Bag.shared.numUnits, forKey: "numUnits")
        aCoder.encode(Bag.shared.items, forKey: "items")
    }
}

class Bag: Scroll, ItemContainer {
    private static var _shared: Bag? = nil
    static var shared: Bag {
        return _shared!
    }
    
    static let defaultWidth: CGFloat = 0
    static let defaultHeight: CGFloat = bHeight - 2 * Scroll.margin
    static let longItemLength: CGFloat = defaultWidth * 0.72
    static let smallItemLength: CGFloat = longItemLength * 0.3
    static let halfOpenLength: CGFloat = smallItemLength * 1.8
    static let closedPos: CGFloat = -bWidth/2 - Bag.defaultWidth/2 + 2 * Axle.headWidth + Scroll.margin
    
    enum BagState {
        case closed, halfOpen, open
    }
    
    private func filterItems() {
        self.filteredItems = self.items.filter({ (item: BagItem) -> Bool in
            if item.canAttach(to: DesignTable.shared.group) {
                if item.parent !== self.content {
                    item.removeFromParent()
                    self.content.addChild(item)
                }
                return true
            } else {
                item.removeFromParent()
                return false
            }
        })
    }
    
    let _containerRect: CGRect
    var containerRect: CGRect {
        return _containerRect
    }
    
    var state: BagState = .closed {
        didSet {
            switch state {
            case .closed:
                close()
                break
            case .halfOpen:
                halfOpen()
                break
            case .open:
                open()
                break
            }
        }
    }
    
    var numUnits: Int
    var items: [BagItem] {
        didSet {
            sortItems()
        }
    }
    var filteredItems: [BagItem] = []
    
    init() {
        self.numUnits = Player.shared.bagData.numUnits
        self._containerRect = CGRect(origin: CGPoint(x: -Bag.defaultWidth * 0.5, y: -Bag.defaultHeight * 0.5), size: CGSize(width: Bag.defaultWidth, height: Bag.defaultHeight))
        items = Player.shared.bagData.items
        super.init(width: Bag.defaultWidth, height: Bag.defaultHeight, isScrollable: true, isVertical: true, maxContentLength: CGFloat(numUnits * 1000))
        Bag._shared = self
        self.isUserInteractionEnabled = true
        self.setLength(0)
        self.position.x = Bag.closedPos
        self.content.addChildren(items)
        for item in items {
            item.didAddToBag()
        }
        sortItems()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func itemFloatOnSelf() {
        if !self.floatingItem.hasActions() {
            adjustItemTransform(self.floatingItem, animate: true)
        }
        self.floatingItem.hideAllAPNs()
        DesignTable.shared.group.hideAllAPNs()
    }
    
    private func isLargeItem(_ item: BagItem) -> Bool {
        let _rect = item.rect
        return max(_rect.width, _rect.height) / item.getScale() > 500
    }
    
    private func adjustItemTransform(_ item: BagItem, animate: Bool = false) {
        item.zPosition = self.zPosition + 20
        let tempZRot = item.zRotation
        item.zRotation = 0
        var destRot: CGFloat = 0
        let _rect = item.rect
        if _rect.width / _rect.height < 1 {
            destRot = CGFloat(Double.pi / 2)
        }
        item.zRotation = tempZRot
        item.rotateToVal(destRot: destRot, animate: animate)
        if isLargeItem(item) {
            item.scaleToMaxWidth(Bag.longItemLength, animate: animate)
        } else {
            item.scaleToSquareContainer(Bag.smallItemLength, animate: animate)
        }
    }
    
    func sortItems() {
        filterItems()
        var largeItems: [BagItem] = []
        var smallItems: [BagItem] = []
        for i in 0..<filteredItems.count {
            filteredItems[i].removeAllActions()
            adjustItemTransform(filteredItems[i])
            if isLargeItem(filteredItems[i]) {
                largeItems.append(filteredItems[i])
            } else {
                smallItems.append(filteredItems[i])
            }
        }
        let margin: CGFloat = 20
        var accPosY: CGFloat = Bag.defaultHeight/2 - Axle.headHeight
        for item in largeItems {
            let halfHeight = item.rect.height * 0.5
            accPosY -= halfHeight
            item.moveToPosition(x: 0, y: accPosY)
            accPosY -= halfHeight + margin
        }
        var posXIdx: Int = 0
        for item in smallItems {
            if posXIdx % 3 == 0 {
                accPosY -= Bag.smallItemLength * 0.5
            }
            item.moveToPosition(x: CGFloat(posXIdx % 3 - 1) * Bag.longItemLength * 0.33, y: accPosY)
            if posXIdx % 3 == 2 {
                accPosY -= Bag.smallItemLength * 0.5 + margin
            }
            posXIdx += 1
        }
    }
    
    private func close() {
        self.animateScroll(self.maxContentLength * 0.5)
        var seq: [SKAction] = []
        if self.contentHeight != 0 {
            let action1 = SKAction.run {
                self.expandToLength(0)
            }
            seq.append(action1)
            seq.append(SKAction.wait(forDuration: action1.duration))
        }
        if self.position.x != Bag.closedPos {
            seq.append(SKAction.run {
                self.moveToPosition(x: Bag.closedPos)
            })
        }
        self.run(SKAction.sequence(seq))
    }
    
    private func halfOpen() {
        self.animateScroll(0)
        var seq: [SKAction] = []
        let destX = Bag.defaultWidth/2 - bWidth/2 + Scroll.margin
        if self.position.x != destX {
            let action1 = SKAction.run {
                self.moveToPosition(x: destX)
            }
            seq.append(action1)
            seq.append(SKAction.wait(forDuration: action1.duration))
        }
        if self.contentHeight != Bag.halfOpenLength {
            seq.append(SKAction.run {
                self.expandToLength(Bag.halfOpenLength)
            })
        }
        self.run(SKAction.sequence(seq))
    }
    
    private func open() {
        self.animateScroll(0)
        var seq: [SKAction] = []
        let destX = Bag.defaultWidth/2 - bWidth/2 + Scroll.margin
        if self.position.x != destX {
            let action1 = SKAction.run {
                self.moveToPosition(x: destX)
            }
            seq.append(action1)
            seq.append(SKAction.wait(forDuration: action1.duration))
        }
        if self.contentHeight != Bag.defaultHeight {
            seq.append(SKAction.run {
                self.expandToLength(Bag.defaultHeight)
            })
        }
        self.run(SKAction.sequence(seq))
    }
    
    func removeItem(_ item: BagItem) -> Bool {
        if FloatingItemContainer.shared.children.count > 0 { return false }
        if item.parent == self.content {
            let pos = item.positionInNode(FloatingItemContainer.shared)
            item.removeFromParent()
            item.position = pos
            FloatingItemContainer.shared.addChild(item)
            for i in 0..<items.count {
                if items[i] === item {
                    items.remove(at: i)
                    return true
                }
            }
        }
        return false
    }
    
    func addItemToSelf() -> Bool {
        if FloatingItemContainer.shared.children.count < 1 { return false }
        let _item = floatingItem
        let pos = _item.positionInNode(self.content)
        _item.removeFromParent()
        _item.position = pos
        self.content.addChild(_item)
        _item.didAddToBag()
        self.items.append(_item)
        return true
    }
    
    override func bottomSwipe(speed: CGFloat) {
        if speed == 0 {
            adjustHeight()
        } else {
            if speed > 0 {
                if self.state == .open {
                    self.state = .halfOpen
                } else {
                    self.state = .closed
                }
            } else {
                if self.state == .closed {
                    self.state = .halfOpen
                } else {
                    self.state = .open
                }
            }
        }
    }
    
    func adjustHeight() {
        if self.contentHeight < Bag.halfOpenLength * 0.5 {
            self.state = .closed
        } else if self.contentHeight < (Bag.halfOpenLength + Bag.defaultHeight) * 0.5 {
            self.state = .halfOpen
        } else {
            self.state = .open
        }
    }
    
    override func bottomDragged(_ by: CGFloat) {
        if self.state != .closed {
            super.bottomDragged(by)
        }
    }
    
    override func bottomTapped() {
        if self.state == .closed {
            self.state = .halfOpen
        }
    }
    
    override func topTapped() {
        if self.state == .closed {
            self.state = .halfOpen
        }
    }
}

