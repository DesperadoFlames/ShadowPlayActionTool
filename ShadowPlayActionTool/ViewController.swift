//
//  ViewController.swift
//  ShadowPlayActionTool
//
//  Created by Desperado on 4/9/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet weak var Alpha: NSButton!
    @IBOutlet weak var label: NSTextField!
    @IBOutlet weak var repeatSwitch: NSButton!
    
    @IBAction func ChangeAlpha(_ sender: Any) {
        if  GameScene.shared!.human.alpha > 0.8 {
            GameScene.shared!.human.alpha = 0.65
        } else {
            GameScene.shared!.human.alpha = 1
        }
    }
    @IBOutlet weak var anchorIsFrontFootSwitch: NSButton!
    @IBOutlet weak var headSlider: NSSlider!
    @IBOutlet weak var bodySlider: NSSlider!
    @IBOutlet weak var backArmSlider: NSSlider!
    @IBOutlet weak var backHandSlider: NSSlider!
    @IBOutlet weak var backThighSlider: NSSlider!
    @IBOutlet weak var backCalfSlider: NSSlider!
    @IBOutlet weak var backFootSlider: NSSlider!
    @IBOutlet weak var frontArmSlider: NSSlider!
    @IBOutlet weak var frontHandSlider: NSSlider!
    @IBOutlet weak var frontThighSlider: NSSlider!
    @IBOutlet weak var frontCalfSlider: NSSlider!
    @IBOutlet weak var frontFootSlider: NSSlider!
    @IBOutlet weak var heightText: NSTextField!
    @IBOutlet weak var durText: NSTextField!
    @IBOutlet weak var actionNoText: NSTextField!
    @IBOutlet weak var timeText: NSTextField!
    @IBOutlet weak var picker: NSPopUpButton!
    
    var copiedVals: [CGFloat] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    var copiedDur: TimeInterval = 0
    var copiedAiff: Bool = false
    
    var valArray: [[CGFloat]] = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]
    var totalTime: TimeInterval = 0
    var anchorIsFrontFoots: [Bool] = [false]
    var timeArray: [TimeInterval] = [0] {
        didSet {
            totalTime = timeArray.reduce(0, {$0 + $1})
        }
    }
    var human: Human {
        return GameScene.shared!.human
    }
    var shouldRepeat: Bool {
        get {
            return repeatSwitch.state == NSOnState
        }
        set {
            repeatSwitch.state = (newValue ? NSOnState : NSOffState)
        }
    }
    var anchorIsFrontFoot: Bool {
        get {
            return anchorIsFrontFootSwitch.state == NSOnState
        }
        set {
            anchorIsFrontFootSwitch.state = (newValue ? NSOnState : NSOffState)
        }
    }
    var height: CGFloat {
        get {
            return CGFloat(Float(heightText.stringValue)!)
        }
        set {
            heightText.stringValue = "\(newValue)"
            human.yOffset = newValue
            valArray[currentIdx][12] = newValue
        }
    }
    var dur: TimeInterval {
        get {
            return Double(durText.stringValue)!
        }
        set {
            let val = max(newValue, 0)
            durText.stringValue = "\(val)"
            timeArray[currentIdx] = val
        }
    }
    
    var time: TimeInterval {
        get {
            return Double(timeText.stringValue)!
        }
        set {
            timeText.stringValue = "\(round(newValue * 10) / 10)"
            var t: TimeInterval = 0
            for i in 0..<timeArray.count {
                t += timeArray[i]
                if t >= newValue {
                    actionNoText.stringValue = "\(i + 1)"
                    break
                }
            }
        }
    }
    @IBAction func resetCurrIdx(_ sender: Any) {
//        if let action = originalAction {
//            if action.actionPoints.count > currentIdx {
//                self.valArray[currentIdx] = action.actionPoints[currentIdx]
//                self.timeArray[currentIdx] = action.durs[currentIdx]
//                self.anchorIsFrontFoots[currentIdx] = action.anchorIsFrontFoots[currentIdx]
//                setElementsToVals()
//            }
//        }
    }
    @IBAction func resetAllIndices(_ sender: Any) {
//        if let action = originalAction {
//            currentIdx = 0
//            valArray = action.actionPoints
//            timeArray = action.durs
//            anchorIsFrontFoots = action.anchorIsFrontFoots
//            shouldRepeat = action.shouldRepeat
//            setElementsToVals()
//        }
    }
    
    var currentIdx: Int {
        get {
            return Int(label.stringValue)! - 1
        }
        set {
            label.stringValue = "\(newValue + 1)"
        }
    }
    
    @IBAction func headEdit(_ sender: NSSlider) {
        valArray[currentIdx][0] = CGFloat(sender.doubleValue)
        human.head?.zRotation = CGFloat(sender.doubleValue)
        human.setWeaponTransform()
    }
    @IBAction func bodyEdit(_ sender: NSSlider) {
        valArray[currentIdx][1] = CGFloat(sender.doubleValue)
        human.body?.zRotation = CGFloat(sender.doubleValue)
        human.setWeaponTransform()
    }
    @IBAction func frontArmEdit(_ sender: NSSlider) {
        valArray[currentIdx][2] = CGFloat(sender.doubleValue)
        human.frontArm?.zRotation = CGFloat(sender.doubleValue)
        human.setWeaponTransform()
    }
    @IBAction func frontHandEdit(_ sender: NSSlider) {
        valArray[currentIdx][3] = CGFloat(sender.doubleValue)
        human.frontHand?.zRotation = CGFloat(sender.doubleValue)
        human.setWeaponTransform()
    }
    @IBAction func backArmEdit(_ sender: NSSlider) {
        valArray[currentIdx][4] = CGFloat(sender.doubleValue)
        human.backArm?.zRotation = CGFloat(sender.doubleValue)
        human.setWeaponTransform()
    }
    
    @IBAction func backHandEdit(_ sender: NSSlider) {
        valArray[currentIdx][5] = CGFloat(sender.doubleValue)
        human.backHand?.zRotation = CGFloat(sender.doubleValue)
        human.setWeaponTransform()
    }
    @IBAction func frontThighEdit(_ sender: NSSlider) {
        valArray[currentIdx][6] = CGFloat(sender.doubleValue)
        human.frontThigh?.zRotation = CGFloat(sender.doubleValue)
        human.setWeaponTransform()
    }
    @IBAction func frontCalfEdit(_ sender: NSSlider) {
        valArray[currentIdx][7] = CGFloat(sender.doubleValue)
        human.frontCalf?.zRotation = CGFloat(sender.doubleValue)
        human.setWeaponTransform()
    }
    @IBAction func backThighEdit(_ sender: NSSlider) {
        valArray[currentIdx][8] = CGFloat(sender.doubleValue)
        human.backThigh?.zRotation = CGFloat(sender.doubleValue)
        human.setWeaponTransform()
    }
    @IBAction func backCalfEdit(_ sender: NSSlider) {
        valArray[currentIdx][9] = CGFloat(sender.doubleValue)
        human.backCalf?.zRotation = CGFloat(sender.doubleValue)
        human.setWeaponTransform()
    }
    @IBAction func frontFootEdit(_ sender: NSSlider) {
        valArray[currentIdx][10] = CGFloat(sender.doubleValue)
        human.frontFoot?.zRotation = CGFloat(sender.doubleValue)
        human.setWeaponTransform()
    }
    @IBAction func backFootEdit(_ sender: NSSlider) {
        valArray[currentIdx][11] = CGFloat(sender.doubleValue)
        human.backFoot?.zRotation = CGFloat(sender.doubleValue)
        human.setWeaponTransform()
    }
    @IBAction func setHumanSpeed(_ sender: NSSlider) {
        human.actionSpeed = sender.doubleValue
    }
    @IBAction func aiffsTouch(_ sender: Any) {
        anchorIsFrontFoots[currentIdx] = anchorIsFrontFoot
    }
    
    
    
    
    
    
    
    
    @IBOutlet var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

