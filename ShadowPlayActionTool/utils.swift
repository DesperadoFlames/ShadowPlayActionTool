//
//  Utils.swift
//  Shadow
//
//  Created by Desperado on 2/3/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit
import Cocoa

let bWidth: CGFloat = 1050
let bHeight: CGFloat = 650
typealias AnimationBlock = ((SKNode, CGFloat) -> Void)

let touchRange: CGFloat = 3
let maximumConnectDistance: CGFloat = 40

func +(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func -(left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func *(left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x*right, y: left.y*right)
}

func /(left: CGPoint, right: CGFloat) -> CGPoint {
    return CGPoint(x: left.x/right, y: left.y/right)
}

func *(left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width*right, height: left.height*right)
}

func /(left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width/right, height: left.height/right)
}

func *(left: CGPoint, right: CGPoint) -> CGFloat {
    return left.x * right.x + left.y * right.y
}
