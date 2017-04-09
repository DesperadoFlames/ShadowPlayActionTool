//
//  extensions.swift
//  Shadow
//
//  Created by Desperado on 2/3/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

extension SKNode {
    func addChildren(_ children: [SKNode]) {
        for child in children {
            self.addChild(child)
        }
    }
    
    func addChildren(args: SKNode?...) {
        for node in args {
            if node != nil {
                self.addChild(node!)
            }
        }
    }
    
    func getScale() -> CGFloat {
        if xScale != yScale {
            fatalError()
        }
        return xScale
    }
    
    func rotateToVal(destRot: CGFloat) {
        self.run(SKAction.rotate(toAngle: destRot, duration: 0.2))
    }
    
    func scaleToVal(destScale: CGFloat) {
        if self.getScale() == destScale { return }
        self.run(SKAction.scale(to: destScale, duration: 0.2))
    }
    
    func moveToPosition(destPoint: CGPoint) {
        self.run(SKAction.move(to: destPoint, duration: 0.2))
    }
    
    func moveToPosition(x: CGFloat? = nil, y: CGFloat? = nil) {
        moveToPosition(destPoint: CGPoint(x: x ?? self.position.x, y: y ?? self.position.y))
    }
    
    func moveByPosition(x: CGFloat? = nil, y: CGFloat? = nil) {
        moveToPosition(x: self.position.x + (x ?? 0), y: self.position.y + (y ?? 0))
    }
    
    func fadeOut(wait: Double = 0, interval: Double = 0.2) {
        self.alpha = 1
        let ab: AnimationBlock = {_, value in
            self.alpha = 1 - value/CGFloat(interval)
        }
        let action = SKAction.customAction(withDuration: interval, actionBlock: ab)
        self.run(wait == 0 ? action : SKAction.sequence([SKAction.wait(forDuration: wait), action]))
    }
    
    var positionInScene: CGPoint {
        return positionInNode(scene!)
    }
    
    func positionInNode(_ node: SKNode) -> CGPoint {
        return self.parent!.convert(position, to: node)
    }
}

extension CGSize {
    var diagonal: CGFloat {
        return sqrt(width*width + height*height)
    }
}

extension CGPoint {
    func distanceTo(_ other: CGPoint) -> CGFloat {
        let deltaX = self.x - other.x
        let deltaY = self.y - other.y
        return sqrt(deltaX * deltaX + deltaY * deltaY)
    }
    
    var length: CGFloat {
        return sqrt(self.x * self.x + self.y * self.y)
    }
}

extension Array where Element: Equatable {
    mutating func remove(object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}

extension NSObject {
    internal func postInit() {
        
    }
}

extension SKTexture {
    func flip(horiz: Bool, vert: Bool) -> SKTexture {
        return self
    }
}

extension Dictionary {
    init(elements:[(Key, Value)]) {
        self.init()
        for (key, value) in elements {
            updateValue(value, forKey: key)
        }
    }
}
