//
//  Player.swift
//  ShadowPlay
//
//  Created by Desperado on 2/15/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class Player: NSObject, NSCoding {
    private static var _shared: Player? = nil
    static var shared: Player {
        if _shared == nil {
            if let instance = StorageManager.shared.getPlayerData() {
                _shared = instance
            } else {
                _shared = Player()
            }
        }
        return _shared!
    }
    
    let bagData: BagData
    
    override init() {
        self.bagData = BagData()
        super.init()
        Player._shared = self
    }
    
    required init(coder aDecoder: NSCoder) {
        self.bagData = aDecoder.decodeObject(forKey: "bagData") as! BagData
        super.init()
        Player._shared = self
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(bagData, forKey: "bagData")
    }
}

class BagItem: SKNode {
    
    func scaleToVal(destVal: CGFloat, animate: Bool = false) {
        if !animate {
            self.setScale(destVal * self.getScale())
        } else {
            self.scaleToVal(destScale: destVal * self.getScale())
        }
    }
    
    func canAttach(to other: BagItem) -> Bool {
        return false
    }
    
    func didAddToBag() {
        self.isUserInteractionEnabled = true
        self.container = Bag.shared
    }
    
    var rect: CGRect {
        return self.frame
    }
    
    var container: ItemContainer? = nil
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
    }
    
    func scaleToContainer(_ size: CGSize, animate: Bool = false) {
        let _rect = self.rect
        scaleToVal(destVal: min(size.width / _rect.width, size.height / _rect.height), animate: animate)
    }
    
    func scaleToSquareContainer(_ width: CGFloat, animate: Bool = false) {
        scaleToContainer(CGSize(width: width, height: width), animate: animate)
    }
    
    func scaleToMaxWidth(_ width: CGFloat, animate: Bool = false) {
        scaleToVal(destVal: width / rect.width, animate: animate)
    }
    
    func scaleToMaxHeight(_ height: CGFloat, animate: Bool = false) {
        scaleToVal(destVal: height / rect.height, animate: animate)
    }
    
    func animateTransformTo(scale: CGFloat? = nil, rotation: CGFloat? = nil, point: CGPoint? = nil) {
        if let _scale = scale {
            self.scaleToVal(destVal: _scale, animate: true)
        }
        if let _rotation = rotation {
            self.rotateToVal(destRot: _rotation, animate: true)
        }
        if let _point = point {
            self.moveToPosition(destPoint: _point, animate: true)
        }
    }
        
    func rotateToVal(destRot: CGFloat, animate: Bool) {
        if animate {
            self.rotateToVal(destRot: destRot)
        } else {
            self.zRotation = destRot
        }
    }
    
    func moveToPosition(destPoint: CGPoint, animate: Bool) {
        if animate {
            self.moveToPosition(destPoint: destPoint)
        } else {
            self.position = destPoint
        }
    }
}
