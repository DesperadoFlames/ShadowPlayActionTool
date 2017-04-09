//
//  Weapon.swift
//  ShadowPlay
//
//  Created by Desperado on 2/15/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class Weapon: BagItem {
    var items: [PlayerCombinablePiece]
    var connections: [Connection]
    var primaryHandAPN: AttachPointNode? = nil
    var isEmpty: Bool {
        return items.count == 0
    }
    
    override var rect: CGRect {
        return self.calculateAccumulatedFrame()
    }
    
    class Connection: NSObject, NSCoding {
        var itemIndex1: Int
        var itemIndex2: Int
        let nodeIndex1: Int
        let nodeIndex2: Int
        
        init(itemIndex1: Int, itemIndex2: Int, nodeIndex1: Int, nodeIndex2: Int) {
            self.itemIndex1 = itemIndex1
            self.itemIndex2 = itemIndex2
            self.nodeIndex1 = nodeIndex1
            self.nodeIndex2 = nodeIndex2
        }
        
        required init?(coder aDecoder: NSCoder) {
            self.itemIndex1 = aDecoder.decodeInteger(forKey: "itemIndex1")
            self.itemIndex2 = aDecoder.decodeInteger(forKey: "itemIndex2")
            self.nodeIndex1 = aDecoder.decodeInteger(forKey: "nodeIndex1")
            self.nodeIndex2 = aDecoder.decodeInteger(forKey: "nodeIndex2")
        }
        
        func encode(with aCoder: NSCoder) {
            aCoder.encode(itemIndex1, forKey: "itemIndex1")
            aCoder.encode(itemIndex2, forKey: "itemIndex2")
            aCoder.encode(nodeIndex1, forKey: "nodeIndex1")
            aCoder.encode(nodeIndex2, forKey: "nodeIndex2")
        }
    }
    
    convenience init(_ item: PlayerCombinablePiece) {
        self.init(items: [item])
    }
    
    init(items: [PlayerCombinablePiece] = [], connections: [Connection] = []) {
        self.items = items
        self.connections = connections
        super.init()
        self.addChildren(items)
        postInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.items = aDecoder.decodeObject(forKey: "items") as! [PlayerCombinablePiece]
        self.connections = aDecoder.decodeObject(forKey: "connections") as! [Connection]
        super.init(coder: aDecoder)
        postInit()
    }
    
    override func postInit() {
        for connection in self.connections {
            let node1 = self.items[connection.itemIndex1].attachPointNodes[connection.nodeIndex1]
            let node2 = self.items[connection.itemIndex2].attachPointNodes[connection.nodeIndex2]
            node1.isConnected = true
            node1.pair!.isConnected = true
            node2.isConnected = true
            node2.pair!.isConnected = true
        }
        setPrimaryHandAPN()
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(items, forKey: "items")
        aCoder.encode(connections, forKey: "connections")
        super.encode(with: aCoder)
    }
    
    override func canAttach(to other: BagItem) -> Bool {
        for piece in self.items {
            if piece.canAttach(to: other) {
                return true
            }
        }
        return false
    }
    
    func setPrimaryHandAPN() {
        for i in self.items {
            let primaryHandAPNs = i.attachPointNodes.filter {return $0.type == .hand && $0.isPrimary}
            if primaryHandAPNs.count == 1 {
                self.primaryHandAPN = primaryHandAPNs.first!
            }
        }
    }
    
    var apns: [AttachPointNode] {
        return self.items.flatMap({ (piece: PlayerCombinablePiece) -> [AttachPointNode] in
            return piece.attachPointNodes
        })
    }
    
    func reactTo(other: Weapon?) {
        if self != DesignTable.shared.group { fatalError() }
        self.hideAllAPNs()
        if other == nil { return }
        other!.hideAllAPNs()
        let selfAPNs = self.apns.filter({$0.isPrimary && !$0.isConnected})
        let otherAPNs = other!.apns.filter({$0.isPrimary && !$0.isConnected})
        for apn in selfAPNs {
            for apn2 in otherAPNs {
                if apn.canAttach(to: apn2) && apn.type == (apn2.parent as! PlayerCombinablePiece).type && apn2.type == (apn.parent as! PlayerCombinablePiece).type {
                    apn.show()
                    apn2.show()
                }
            }
        }
        if let spec = reactToAPNPair(toAddAPNs: otherAPNs, selfActiveAPNs: selfAPNs, grp: other!) {
            if !other!.hasActions() {
                other!.rotateToVal(destRot: other!.zRotation + spec.0, animate: true)
            }
        }
    }
    
    override func didAddToBag() {
        super.didAddToBag()
        DesignTable.shared.group.reactTo(other: self)
        hideAllAPNs()
    }
    
    func showAllAPNs() {
        for i in self.items {
            i.showAllAPNs()
        }
    }
    
    func hideAllAPNs() {
        for i in self.items {
            i.hideAllAPNs()
        }
    }
    
    func rescaleToDesignArea() {
        self.removeAllActions()
        let _rect = self.rect
        let originalY = (DesignTable.shared.contentWidth - DesignTable.shared.contentHeight) / 2
        for child in self.children {
            child.moveByPosition(x: -_rect.midX / self.getScale(), y: (originalY - _rect.midY) / self.getScale())
        }
        self.hideAllAPNs()
        self.scaleToSquareContainer(DesignTable.defaultGroupWidth)
    }
    
    func calcScaleToDesignTable() -> CGFloat {
        let _rect = self.rect
        return DesignTable.defaultGroupWidth / max(_rect.width, _rect.height) * self.getScale()
    }
    
    func reactToAPNPair(toAddAPNs: [AttachPointNode], selfActiveAPNs: [AttachPointNode], grp: Weapon) -> (CGFloat, CGPoint, CGPoint, AttachPointNode, AttachPointNode)? {
        var minDistance: CGFloat = maximumConnectDistance
        var nearsetAPN: AttachPointNode? = nil
        var nearsetAPN2: AttachPointNode? = nil
        var groupPosChange: CGPoint? = nil
        var t: CGPoint? = nil
        for apn in toAddAPNs where apn.isPrimary && apn.hasPair {
            let toConnectCenterPosInSelf = (apn.pair!.positionInNode(self) + apn.positionInNode(self)) / 2
            for apn2 in selfActiveAPNs where apn2.isPrimary && apn2.hasPair {
                let selfConnectCenterPosInSelf = (apn2.pair!.positionInNode(self) + apn2.positionInNode(self)) / 2
                let currentDistance = toConnectCenterPosInSelf.distanceTo(selfConnectCenterPosInSelf)
                if currentDistance < minDistance {
                    groupPosChange = selfConnectCenterPosInSelf - toConnectCenterPosInSelf
                    minDistance = currentDistance
                    nearsetAPN = apn
                    nearsetAPN2 = apn2
                    t = toConnectCenterPosInSelf
                }
            }
        }
        if nearsetAPN == nil { return nil }
        let addedVec = nearsetAPN!.pair!.positionInNode(self) - nearsetAPN!.positionInNode(self)
        let originalVec = nearsetAPN2!.pair!.positionInNode(self) - nearsetAPN2!.positionInNode(self)
        let _originalTheta = atan2(originalVec.y, originalVec.x)
        let _addedTheta = atan2(addedVec.y, addedVec.x)
        let theta = (_originalTheta < 0 ? _originalTheta + CGFloat(Double.pi * 2) : _originalTheta) - (_addedTheta < 0 ? _addedTheta + CGFloat(Double.pi * 2) : _addedTheta)
        let c = grp.positionInNode(self)
        let pos = (CGPoint(x: -sin(theta) * (c.y - t!.y) + cos(theta) * (c.x - t!.x),
                                y: sin(theta) * (c.x - t!.x) + cos(theta) * (c.y - t!.y)) - (c - t!)) * grp.getScale()
        return (theta, pos, groupPosChange!, nearsetAPN!, nearsetAPN2!)
    }
    
    func addPiece(_ grp: Weapon) -> Bool {
        let result = addPieceWithoutSettingPrimaryHandAPN(grp)
        if result && self.primaryHandAPN == nil {
            self.setPrimaryHandAPN()
        }
        return result
    }
    
    private func addPieceWithoutSettingPrimaryHandAPN(_ grp: Weapon) -> Bool {
        if self.items.count == 0 {
            self.items = grp.items
            self.connections = grp.connections
            grp.removeFromParent()
            grp.removeAllChildren()
            self.addChildren(items)
            self.rescaleToDesignArea()
            self.isUserInteractionEnabled = true
            return true
        } else {
            let toAddAPNs = grp.apns.filter({$0.alpha > 0.5})
            let selfActiveAPNs = self.apns.filter({$0.alpha > 0.5})
            let spec = reactToAPNPair(toAddAPNs: toAddAPNs, selfActiveAPNs: selfActiveAPNs, grp: grp)
            if spec == nil { return false }
            self.items.append(contentsOf: grp.items)
            let theta = spec!.0
            let posChange = spec!.1
            let groupPosChange = spec!.2
            let nearsetAPN = spec!.3
            let nearsetAPN2 = spec!.4
            grp.zRotation += theta
            grp.position = grp.position + posChange
            for item in grp.items {
                item.position = item.positionInNode(self)
                item.position.x += groupPosChange.x
                item.position.y += groupPosChange.y
            }
            grp.removeFromParent()
            grp.removeAllChildren()
            let connectionPlus = self.items.count
            for connection in grp.connections {
                connection.itemIndex1 += connectionPlus
                connection.itemIndex2 += connectionPlus
            }
            self.connections.append(contentsOf: grp.connections)
            nearsetAPN.isConnected = true
            nearsetAPN2.isConnected = true
            nearsetAPN.pair!.isConnected = true
            nearsetAPN2.pair!.isConnected = true
            let piece1 = nearsetAPN.parent as! PlayerCombinablePiece
            let piece2 = nearsetAPN2.parent as! PlayerCombinablePiece
            self.connections.append(Connection(itemIndex1: items.index(of: piece1)!, itemIndex2: items.index(of: piece2)!, nodeIndex1: piece1.attachPointNodes.index(of: nearsetAPN)!, nodeIndex2: piece2.attachPointNodes.index(of: nearsetAPN2)!))
            self.addChildren(grp.items)
            self.rescaleToDesignArea()
            return true
        }
    }

    func removeFromContainer() {
        self.run(SKAction.sequence([SKAction.wait(forDuration: 0.12), SKAction.run({
            _ = self.container?.removeItem(self)
            self.moveByPosition(y: 30)
        })]))
    }

    var originalTouchPoint: CGPoint = .zero
    var lastTouchPoint: CGPoint = .zero
    var originalPosY: CGFloat = 0
    var maxXYoffset: CGFloat = 0
    var timeSinceTouch: TimeInterval = 0
    var containerTouchBegan: Bool = false

    private func getContainerAtBack() -> ItemContainer? {
        for node in scene!.nodes(at: self.positionInNode(scene!)) {
            if let tempContainer = node as? ItemContainer {
                if tempContainer.acceptsNode(self) {
                    return tempContainer
                }
            }
        }
        return nil
    }
    
    private func destroy() {
        
    }
    
    private func mirror() {
        if self.items.count != 1 { return }
        let item = self.items[0]
        if item.attachPointNodes.count != 2 { return }
        let node1 = item.attachPointNodes[0]
        let node2 = item.attachPointNodes[1]
        if node1.pair != node2 { return }
        let vec = node1.position - node2.position
        let tSize = item.texture!.size()
        let width = tSize.width
        let height = tSize.height
        if vec.x == 0 {
            item.texture = item.texture?.flip(horiz: true, vert: false)
            node1.initialPoint.x = width - node1.initialPoint.x
            node2.initialPoint.x = width - node2.initialPoint.x
        } else if vec.y == 0 {
            item.texture = item.texture?.flip(horiz: false, vert: true)
            node1.initialPoint.y = height - node1.initialPoint.y
            node2.initialPoint.y = height - node2.initialPoint.y
        }
        node1.reanchor()
        node2.reanchor()
        node1.distance!.center = (node1.position + node2.position)/2
    }
    
    override func setScale(_ scale: CGFloat) {
        super.setScale(scale)
        for item in self.items {
            for apn in item.attachPointNodes {
                apn.setScale(1 / scale)
            }
        }
    }
    
    override func scaleToVal(destScale: CGFloat) {
        let oldScale = self.getScale()
        if oldScale == destScale { return }
        let ab: AnimationBlock = {_, value in
            let val = 5 * value
            self.setScale(oldScale + (destScale - oldScale) * val)
        }
        self.run(SKAction.customAction(withDuration: 0.2, actionBlock: ab))
    }
    
    func removePiece(piece: PlayerCombinablePiece) {
        /// Reset connections
        self.items.remove(object: piece)
    }
}
