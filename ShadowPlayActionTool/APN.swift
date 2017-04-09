//
//  APN.swift
//  ShadowPlay
//
//  Created by Desperado on 2/22/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class APNDistance {
    let primaryNode: AttachPointNode
    let secondaryNode: AttachPointNode
    let distance: CGFloat
    var center: CGPoint
    
    init(primaryNode: AttachPointNode, secondaryNode: AttachPointNode) {
        self.primaryNode = primaryNode
        self.secondaryNode = secondaryNode
        self.distance = primaryNode.position.distanceTo(secondaryNode.position)
        self.center = (primaryNode.position + secondaryNode.position)/2
    }
}

class AttachPointNode: SKShapeNode {
    var distance: APNDistance? = nil
    var isConnected: Bool = false
    var isPrimary: Bool = true
    var anchorPosX: CGFloat = 0
    var anchorPosY: CGFloat = 0
    var hasPair: Bool {
        return distance != nil
    }
    var pair: AttachPointNode? {
        return isPrimary ? self.distance?.secondaryNode : self.distance?.primaryNode
    }
    
    enum AttachPointNodeType: Int {
        case preset = 0
        case weapon = 1
        case hand = 2
        case auxiliary = 3
        case head = 4
        case body = 5
        case arm = 6
        case thigh = 7
        case calf = 8
        case foot = 9
    }
    
    let type: AttachPointNodeType
    var initialPoint: CGPoint
    
    required init?(coder aDecoder: NSCoder) {
        self.type = AttachPointNodeType.init(rawValue: aDecoder.decodeInteger(forKey: "type"))!
        self.initialPoint = aDecoder.decodePoint(forKey: "initialPoint")
        super.init(coder: aDecoder)
        postInit()
    }
    
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.type.rawValue, forKey: "type")
        aCoder.encode(self.initialPoint, forKey: "initialPoint")
        super.encode(with: aCoder)
    }
    
    static func pair(primaryNode: AttachPointNode, secondaryNode: AttachPointNode) {
        let apnDistance = APNDistance(primaryNode: primaryNode, secondaryNode: secondaryNode)
        (primaryNode.parent as! ShadowPlayPiece).apnDistances.append(apnDistance)
        primaryNode.distance = apnDistance
        secondaryNode.distance = apnDistance
        primaryNode.isPrimary = true
        secondaryNode.isPrimary = false
    }
    
    init(point: CGPoint, type: AttachPointNodeType) {
        self.type = type
        self.initialPoint = point - CGPoint(x: 5, y: 5)
        super.init()
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        let frame = CGSize(width: 2, height: 2)
        self.path = CGPath(ellipseIn: CGRect(origin: .zero, size: frame), transform: nil)
        let color: SKColor = {
            switch type {
            case .preset:
                return .clear
            case .weapon:
                return .red
            case .auxiliary:
                return SKColor(red: 0.384, green: 0.796, blue: 1, alpha: 1)
            default:
                return .white
            }
        }()
        self.fillColor = color
        self.strokeColor = color
        self.zPosition = 5
    }
    
    convenience init(x: CGFloat, y: CGFloat, type: AttachPointNodeType) {
        self.init(point: CGPoint(x: x, y: y), type: type)
    }
    
    func reanchor() {
        let p = self.parent as! ShadowPlayPiece
        let parentSize = p.texture!.size() * 16.666666667
        self.anchorPosX = initialPoint.x / parentSize.width
        self.anchorPosY = initialPoint.y / parentSize.height
        reposition(p: p)
    }
    
    func reposition(p: ShadowPlayPiece) {
        let parentSize = p.texture!.size() * 16.666666667
        self.position = CGPoint(x: (self.anchorPosX - p.anchorPoint.x) * parentSize.width, y: (self.anchorPosY - p.anchorPoint.y) * parentSize.height)
    }
    
    func canAttach(to other: AttachPointNode) -> Bool {
        if (self.isConnected || other.isConnected) { return false }
        if self.hasPair != other.hasPair { return false }
        if !self.hasPair {return true}
        return abs(self.distance!.distance - other.distance!.distance) < 2
    }
    
    func hide() {
        if self.hasPair {
            self.distance?.secondaryNode.alpha = 0
            self.distance?.primaryNode.alpha = 0
        } else {
            self.alpha = 0
        }
    }
    
    func show() {
        if self.hasPair {
            self.distance?.secondaryNode.alpha = 1
            self.distance?.primaryNode.alpha = 1
        } else {
            self.alpha = 1
        }
    }
}
