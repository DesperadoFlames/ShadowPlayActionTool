//
//  Scroll.swift
//  ShadowPlay
//
//  Created by Desperado on 2/16/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class Shade: SKSpriteNode {
    init(width: CGFloat, height: CGFloat) {
        super.init(texture: SKTexture(imageNamed: "shade"), color: .clear, size: CGSize(width: width - height, height: height))
        let sideSize = CGSize(width: height / 2, height: height)
        let side1 = SKSpriteNode(texture: SKTexture(imageNamed: "shade_left"), size: sideSize)
        let side2 = SKSpriteNode(texture: SKTexture(imageNamed: "shade_right"), size: sideSize)
        side1.position.x = (height / 2 - width) / 2
        side2.position.x = -side1.position.x
        self.addChildren(args: side1, side2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Axle: SKNode {
    static let defaultWidth: CGFloat = 10
    static let headWidth: CGFloat = 10
    static let headHeight: CGFloat = headWidth * 1.5
    private let crop: SKCropNode
    private var _paperRemain: CGFloat = 1
    private let paperNode: ContentRepeater
    private let shade: Shade
    private let mask: SKSpriteNode
    var paperRemain: CGFloat {
        get {
            return _paperRemain
        }
        set {
            _paperRemain = min(max(0, newValue), 1)
            crop.position.y = 0
            mask.size.height = (_paperRemain + 1) * Axle.defaultWidth
            shade.position.y = mask.frame.minY
        }
    }
    
    init(length: CGFloat) {
        let axleMain = SKSpriteNode(color: .black, size: CGSize(width: length - 2 * Axle.headWidth, height: Axle.defaultWidth))
        paperNode = ContentRepeater(width: length - 2 * Axle.defaultWidth, height: 2 * Axle.defaultWidth, isVertical: true, imageName: "scrollAxlePaper")
        self.crop = SKCropNode()
        self.shade = Shade(width: (length - 2 * Axle.headWidth) * 0.97, height: Axle.defaultWidth)
        self.mask = SKSpriteNode(color: .black, size: CGSize(width: length - 2 * Axle.defaultWidth, height: 2 * Axle.defaultWidth))
        super.init()
        crop.maskNode = mask
        crop.addChild(paperNode)
        shade.zPosition = self.zPosition - 1
        self.addChild(shade)
        let leftHead = SKSpriteNode(texture: SKTexture(imageNamed: "scrollAxleHead_1"), color: .clear, size: CGSize(width: Axle.headWidth, height: Axle.headHeight))
        let rightHead = SKSpriteNode(texture: SKTexture(imageNamed: "scrollAxleHead_2"), color: .clear, size: CGSize(width: Axle.headWidth, height: Axle.headHeight))
        rightHead.position.x = (length - Axle.headWidth) / 2
        leftHead.position.x = -rightHead.position.x
        self.addChildren(args: axleMain, crop, leftHead, rightHead)
    }
    
    func scroll(_ by: CGFloat) {
        self.paperNode.scroll(by)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ContentRepeater: SKNode {
    private var holders: [SKSpriteNode] = []
    private let holderLength: CGFloat
    private let isVertical: Bool
    private let length: CGFloat
    
    convenience init(width: CGFloat, height: CGFloat, isVertical: Bool, imageName: String) {
        let texture = SKTexture(imageNamed: imageName)
        let tSize = texture.size()
        self.init(width: width, height: height, isVertical: isVertical, repeatingSprite: SKSpriteNode(texture: texture, size: CGSize(width: isVertical ? width : height, height : (isVertical ? width : height) * tSize.height / tSize.width)), originalSize: tSize)
    }
    
    init(width: CGFloat, height: CGFloat, isVertical: Bool, repeatingSprite: SKSpriteNode, originalSize: CGSize) {
        self.isVertical = isVertical
        self.length = isVertical ? height : width
        self.holderLength = (isVertical ? width : height) * originalSize.height / originalSize.width
        for _ in 0..<(Int(length / holderLength) + 2) {
            self.holders.append(repeatingSprite.copy() as! SKSpriteNode)
        }
        super.init()
        if isVertical {
            var accPosY = height / 2 * holderLength
            for holder in holders {
                holder.position.y = accPosY
                accPosY -= holderLength
            }
        } else {
            var accPosX = width / 2 * holderLength
            for holder in holders {
                holder.zRotation = CGFloat(Double.pi / 2)
                holder.position.x = accPosX
                accPosX -= holderLength
            }
        }
        self.addChildren(holders)
    }
    
    func scroll(_ by: CGFloat) {
        if isVertical {
            holders[0].position.y += by
            while(holders[0].position.y > (holderLength + length) / 2) {
                holders[0].position.y -= holderLength
            }
            while(holders[0].position.y < (length - holderLength) / 2) {
                holders[0].position.y += holderLength
            }
            for i in 1..<holders.count {
                holders[i].position.y = holders[i-1].position.y - holderLength
            }
        } else {
            holders[0].position.x += by
            while(holders[0].position.x > (holderLength + length) / 2) {
                holders[0].position.x -= holderLength
            }
            while(holders[0].position.x < (length - holderLength) / 2) {
                holders[0].position.x += holderLength
            }
            for i in 1..<holders.count {
                holders[i].position.x = holders[i-1].position.x - holderLength
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Scroll: SKNode {
    static let margin: CGFloat = 10
    static let sideWidth: CGFloat = bWidth * 0.02
    
    private let top: Axle
    private let bottom: Axle
    private let holder: ContentRepeater
    let maxContentLength: CGFloat
    private var scrollPos: CGFloat
    var isScrollable: Bool
    let isVertical: Bool
    let content: SKNode
    let divs: [CGFloat]
    private let mask: SKSpriteNode
    internal var contentWidth: CGFloat
    internal var contentHeight: CGFloat
    
    init(width: CGFloat, height: CGFloat, isScrollable: Bool = false, isVertical: Bool, maxContentLength: CGFloat = CGFloat.infinity, divs: [CGFloat] = [0]) {
        self.divs = divs
        self.isScrollable = isScrollable
        scrollPos = isScrollable ? 0 : CGFloat.infinity
        self.isVertical = isVertical
        let axleLength = isVertical ? width : height
        self.top = Axle(length: axleLength)
        self.bottom = Axle(length: axleLength)
        self.contentHeight = height - 2 * (isVertical ? Axle.headHeight : Axle.headWidth)
        self.contentWidth = width - 2 * (isVertical ? Axle.headWidth : Axle.headHeight)
        self.maxContentLength = maxContentLength - (isVertical ? contentHeight : contentWidth)
        let sideTexture = SKTexture(imageNamed: "scrollContentSide")
        let mainTexture = SKTexture(imageNamed: "scrollContentMain")
        let spriteScale = Scroll.sideWidth / sideTexture.size().width
        let sideSize = CGSize(width: Scroll.sideWidth, height: sideTexture.size().height * spriteScale)
        let mainSize = CGSize(width: mainTexture.size().width * spriteScale, height: sideSize.height)
        let side = SKSpriteNode(texture: sideTexture, size: sideSize)
        let side2 = side.copy() as! SKSpriteNode
        let sprite = SKSpriteNode(texture: mainTexture, size: mainSize)
        side.zPosition = sprite.zPosition + 1
        side2.zPosition = sprite.zPosition + 1
        var mainCopies: [SKSpriteNode] = []
        let n = Int((isVertical ? contentWidth : contentHeight) / mainSize.width)
        for _ in 0..<(n % 2 == 0 ? n : n + 1) {
            mainCopies.append(sprite.copy() as! SKSpriteNode)
        }
        if isVertical {
            side.position.x = (contentWidth - Scroll.sideWidth) / 2
            side2.position.x = -side.position.x
            for i in stride(from: 0, through: mainCopies.count-1, by: 2) {
                mainCopies[i].position.x = CGFloat(i/2+1) * mainSize.width
                mainCopies[i+1].position.x = -mainCopies[i].position.x
            }
        } else {
            side.position.y = (contentHeight - Scroll.sideWidth) / 2
            side2.position.y = -side.position.y
            for i in stride(from: 0, through: mainCopies.count-1, by: 2) {
                mainCopies[i].position.y = CGFloat(i/2+1) * mainSize.width
                mainCopies[i+1].position.y = -mainCopies[i].position.y
            }
        }
        sprite.addChildren(mainCopies)
        sprite.addChildren(args: side, side2)
        self.holder = ContentRepeater(width: contentWidth, height: contentHeight, isVertical: isVertical, repeatingSprite: sprite, originalSize: CGSize(width: contentWidth, height: sideSize.height))
        self.content = SKNode()
        self.mask = SKSpriteNode(color: .black, size: CGSize(width: (isVertical ? contentWidth : contentWidth + Axle.defaultWidth * 2), height: (isVertical ? contentHeight + Axle.defaultWidth * 2 : contentHeight)))
        super.init()
        let crop = SKCropNode()
        crop.maskNode = mask
        bottom.zRotation = CGFloat(Double.pi)
        if isVertical {
            top.position.y = (height - Axle.headHeight) / 2
            bottom.position.y = -top.position.y
        } else {
            top.zRotation -= CGFloat(Double.pi / 2)
            bottom.zRotation -= CGFloat(Double.pi / 2)
            top.position.x = (width - Axle.headWidth) / 2
            bottom.position.x = -top.position.x
        }
        crop.addChildren(args: content, holder)
        self.addChildren(args: top, bottom, crop)
        self.top.zPosition = 10
        self.bottom.zPosition = self.top.zPosition + 1
        safeScroll(0)
        self.isUserInteractionEnabled = true
    }
    
    func safeScroll(_ diff: CGFloat) {
        self.holder.scroll(diff)
        self.top.scroll(-diff)
        self.bottom.scroll(diff)
        if isVertical {
            self.content.position.y += diff
        } else {
            self.content.position.x += diff
        }
        scrollPos += diff
        self.top.paperRemain = scrollPos / maxContentLength
        self.bottom.paperRemain = 1 - scrollPos / maxContentLength
    }
    
    func adjustPosition(speed: CGFloat) {
        let ab: AnimationBlock = {_, value in
            self.scroll(speed * 0.05 * (0.6 - value))
        }
        let action = SKAction.customAction(withDuration: 0.6, actionBlock: ab)
        self.run(action)
    }
    
    func animateScroll(_ to: CGFloat) {
        if isScrollable {
            let diff = to - self.scrollPos
            var lastVal: CGFloat = 0
            let ab: AnimationBlock = {_, value in
                self.scroll((value - lastVal) * 5 * diff)
                lastVal = value
            }
            let action = SKAction.customAction(withDuration: 0.2, actionBlock: ab)
            self.run(action)
        }
    }
    
    func scroll(_ by: CGFloat) {
        if isScrollable {
            safeScroll(by > 0 ? min(by, maxContentLength - scrollPos) : max(by, -scrollPos))
        }
    }
    
    func changeLength(_ by: CGFloat) {
        setLength(self.contentHeight + by)
    }
    
    func setLength(_ newVal: CGFloat) {
        let _newVal = max(newVal, 0)
        if isVertical {
            self.mask.size.height = _newVal + Axle.defaultWidth * 2
            let posDiff = (_newVal - self.contentHeight) / 2
            self.mask.position.y -= posDiff
            self.bottom.position.y -= posDiff * 2
            self.bottom.scroll(2 * posDiff)
            self.contentHeight = _newVal
        } else {
            self.mask.size.width = _newVal + Axle.defaultWidth * 2
            let posDiff = (_newVal - self.contentWidth) / 2
            self.mask.position.x -= posDiff
            self.bottom.position.x -= posDiff * 2
            self.bottom.scroll(2 * posDiff)
            self.contentWidth = _newVal
        }
    }
    
    func expandToLength(_ newVal: CGFloat) {
        let _newVal = newVal - Axle.headHeight * 2
        let oriLength = isVertical ? self.contentHeight : self.contentWidth
        let ab: AnimationBlock = {_, value in
            let val = 5 * value
            self.setLength(oriLength * (1 - val) + _newVal * val)
        }
        let action = SKAction.customAction(withDuration: 0.2, actionBlock: ab)
        self.run(action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Scroll {
    func topTapped() {
        
    }
    
    func bottomTapped() {
        
    }
    
    func bottomDragged(_ by: CGFloat) {
        if isScrollable {
            self.changeLength(-by)
        }
    }
    
    func bottomSwipe(speed: CGFloat) {
        
    }
}
