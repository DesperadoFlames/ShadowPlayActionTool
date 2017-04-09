//
//  GameScene.swift
//  ShadowPlayActionTool
//
//  Created by Desperado on 4/9/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    static var shared: GameScene? = nil
    
    var human: Human = Human(body: Body_2(), head: Head_2())
    
    override func didMove(to view: SKView) {
        GameScene.shared = self
        
        let background = Background()
        let floatingItemContainer = FloatingItemContainer()
        addChildren(args: background, floatingItemContainer)
        //        demoScroll()
        demoHuman()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}


/// For testing
extension GameScene {
    
    //    func demoWorkStationScene() {
    //        let workStation = WorkStation()
    //        self.addChild(workStation)
    //    }
    
    func demoHead() {
        let head = SKSpriteNode(imageNamed: "head")
        self.addChild(head)
    }
    
    func demoScroll() {
        let designTable = DesignTable()
        let bag = Bag()
        //        let s = Scroll(width: 500, height: 300, isScrollable: true, isVertical: false, maxContentLength: 1500)
        self.addChildren(args: bag, designTable)
        bag.state = .open
        //        bag.expandToLength(300)
    }
    
    func demoHuman() {
        human.frontArm = Arm_1()
        human.backArm = Arm_1()
        human.frontHand = Hand_1()
        human.backHand = Hand_1()
        human.frontThigh = Thigh_1()
        human.backThigh = Thigh_1()
        human.frontCalf = Calf_1()
        human.backCalf = Calf_1()
        human.frontFoot = Foot_1()
        human.backFoot = Foot_1()
        
//        human.frontArm = Arm_2()
//        human.backArm = Arm_2()
//        human.frontHand = Hand_2()
//        human.backHand = Hand_2()
//        human.frontThigh = Thigh_2()
//        human.backThigh = Thigh_2()
//        human.frontCalf = Calf_2()
//        human.backCalf = Calf_2()
//        human.frontFoot = Foot_2()
//        human.backFoot = Foot_2()
        human.combine()
        self.addChild(human)
        human.setScale(0.045)
        human.position.y = -human.calculateAccumulatedFrame().minY - human.parent!.frame.height / 2
    }
}

class Temp_long_blade_combined: WeaponAuxPiece {
    init() {
        super.init(imgStr: "temp_long_blade_combined", attachPointNodes: [AttachPointNode(x: 515, y: 500, type: .hand), AttachPointNode(x: 515, y: 2100, type: .hand)], mass: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        AttachPointNode.pair(primaryNode: self.attachPointNodes[0], secondaryNode: self.attachPointNodes[1])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
}

class Temp_blade_combined: WeaponAuxPiece {
    init() {
        super.init(imgStr: "temp_blade_combined", attachPointNodes: [AttachPointNode(x: 506, y: 358, type: .hand)], mass: 0)
        postInit()
    }
    
    override func postInit() {
        super.postInit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInit()
    }
    
}
