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
    @IBOutlet weak var actionNameField: NSTextField!
    @IBOutlet weak var actionTextField: NSTextField!
    @IBOutlet weak var addButton: NSButton!
    @IBOutlet weak var deleteButton: NSButton!
    
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
    @IBAction func head_reverse(_ sender: Any) {
        headSlider.doubleValue = 0
        valArray[currentIdx][0] = 0
        human.head?.zRotation = 0
        human.setWeaponTransform()
    }
    @IBAction func body_reverse(_ sender: Any) {
        bodySlider.doubleValue = 0
        valArray[currentIdx][1] = 0
        human.body?.zRotation = 0
        human.setWeaponTransform()
    }
    @IBAction func frontArm_reverse(_ sender: Any) {
        frontArmSlider.doubleValue = 0
        valArray[currentIdx][2] = 0
        human.frontArm?.zRotation = 0
        human.setWeaponTransform()
    }
    @IBAction func frontHand_reverse(_ sender: Any) {
        frontHandSlider.doubleValue = 0
        valArray[currentIdx][3] = 0
        human.frontHand?.zRotation = 0
        human.setWeaponTransform()
    }
    @IBAction func backArm_reverse(_ sender: Any) {
        backArmSlider.doubleValue = 0
        valArray[currentIdx][4] = 0
        human.backArm?.zRotation = 0
        human.setWeaponTransform()
    }
    @IBAction func backHand_reverse(_ sender: Any) {
        backHandSlider.doubleValue = 0
        valArray[currentIdx][5] = 0
        human.backHand?.zRotation = 0
        human.setWeaponTransform()
    }
    @IBAction func frontThigh_reverse(_ sender: Any) {
        frontThighSlider.doubleValue = 0
        valArray[currentIdx][6] = 0
        human.frontThigh?.zRotation = 0
        human.setWeaponTransform()
    }
    
    @IBAction func frontCalf_reverse(_ sender: Any) {
        frontCalfSlider.doubleValue = 0
        valArray[currentIdx][7] = 0
        human.frontCalf?.zRotation = 0
        human.setWeaponTransform()
    }
    @IBAction func backThigh_reverse(_ sender: Any) {
        backThighSlider.doubleValue = 0
        valArray[currentIdx][8] = 0
        human.backThigh?.zRotation = 0
        human.setWeaponTransform()
    }
    @IBAction func backCalf_reverse(_ sender: Any) {
        backCalfSlider.doubleValue = 0
        valArray[currentIdx][9] = 0
        human.backCalf?.zRotation = 0
        human.setWeaponTransform()
    }
    @IBAction func frontFoot_reverse(_ sender: Any) {
        frontFootSlider.doubleValue = 0
        valArray[currentIdx][10] = 0
        human.frontFoot?.zRotation = 0
        human.setWeaponTransform()
    }
    @IBAction func backFoot_reverse(_ sender: Any) {
        backFootSlider.doubleValue = 0
        valArray[currentIdx][11] = 0
        human.backFoot?.zRotation = 0
        human.setWeaponTransform()
    }
    @IBAction func heightPlusOne(_ sender: Any) {
        height += 1
    }
    @IBAction func heightMinusOne(_ sender: Any) {
        height -= 1
    }
    @IBAction func heightPlusTen(_ sender: Any) {
        height += 10
    }
    @IBAction func heightMinusTen(_ sender: Any) {
        height -= 10
    }
    @IBAction func durPlusPPOne(_ sender: Any) {
        dur += 0.01
    }
    @IBAction func durMinusPPOne(_ sender: Any) {
        dur -= 0.01
    }
    @IBAction func durPlusPOne(_ sender: Any) {
        dur += 0.1
    }
    @IBAction func durMinusPOne(_ sender: Any) {
        dur -= 0.1
    }
    @IBAction func resetX(_ sender: Any) {
        human.position.x = -450
    }
    @IBAction func resetX_r(_ sender: Any) {
        human.position.x = 450
    }
    
    @IBAction func First(_ sender: Any) {
        currentIdx = 0
        setElementsToVals()
    }
    @IBAction func Up(_ sender: Any) {
        if currentIdx < valArray.count-1 {
            currentIdx += 1
            if valArray.count <= currentIdx {
                valArray.append([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
                timeArray.append(0)
                anchorIsFrontFoots.append(false)
            }
            setElementsToVals()
        }
    }
    @IBAction func Insert(_ sender: Any) {
        valArray.insert(valArray[currentIdx], at: currentIdx+1)
        timeArray.insert(timeArray[currentIdx], at: currentIdx+1)
        anchorIsFrontFoots.insert(anchorIsFrontFoots[currentIdx], at: currentIdx+1)
        currentIdx += 1
        setElementsToVals()
    }
    @IBAction func InsertCurrent(_ sender: Any) {
        let temp = [human.head!.zRotation, human.body!.zRotation, human.frontArm!.zRotation, human.frontHand!.zRotation, human.backArm!.zRotation, human.backHand!.zRotation, human.frontThigh!.zRotation, human.frontCalf!.zRotation, human.backThigh!.zRotation, human.backCalf!.zRotation, human.frontFoot!.zRotation, human.backFoot!.zRotation, 0]
        valArray.insert(temp, at: currentIdx+1)
        timeArray.insert(timeArray[currentIdx], at: currentIdx+1)
        anchorIsFrontFoots.insert(anchorIsFrontFoots[currentIdx], at: currentIdx+1)
        currentIdx += 1
        setElementsToVals()
        human.setWeaponTransform()
    }
    @IBAction func Down(_ sender: Any) {
        if currentIdx >= 1 {
            currentIdx -= 1
        }
        setElementsToVals()
    }
    @IBAction func Last(_ sender: Any) {
        currentIdx = valArray.count - 1
        setElementsToVals()
    }
    @IBAction func copyIdx(_ sender: Any) {
        copiedVals = valArray[currentIdx]
        copiedDur = timeArray[currentIdx]
        copiedAiff = anchorIsFrontFoots[currentIdx]
    }
    @IBAction func pasteIdx(_ sender: Any) {
        valArray[currentIdx] = copiedVals
        timeArray[currentIdx] = copiedDur
        anchorIsFrontFoots[currentIdx] = copiedAiff
        setElementsToVals()
    }
    @IBAction func deleteIdx(_ sender: Any) {
        if currentIdx >= 1 {
            currentIdx -= 1
            setElementsToVals()
            valArray.remove(at: currentIdx + 1)
            timeArray.remove(at: currentIdx + 1)
            anchorIsFrontFoots.remove(at: currentIdx + 1)
        } else {
            clear()
        }
    }
    @IBAction func clearIdx(_ sender: Any) {
        clear()
    }
    @IBAction func handShift(_ sender: Any) {
        shiftPairs([(2, 4), (3, 5)])
        setElementsToVals()
    }
    @IBAction func footShift(_ sender: Any) {
        shiftPairs([(6, 8), (7, 9), (10, 11)])
        anchorIsFrontFoots[currentIdx] = !anchorIsFrontFoot
        setElementsToVals()
    }
    
    private func shiftPairs(_ toShift: [(Int, Int)]) {
        let idx = currentIdx
        for pair in toShift {
            let t = valArray[idx][pair.0]
            valArray[idx][pair.0] = valArray[idx][pair.1]
            valArray[idx][pair.1] = t
        }
    }
    func clear() {
        headSlider.doubleValue = 0
        bodySlider.doubleValue = 0
        frontArmSlider.doubleValue = 0
        frontHandSlider.doubleValue = 0
        backArmSlider.doubleValue = 0
        backHandSlider.doubleValue = 0
        frontThighSlider.doubleValue = 0
        frontCalfSlider.doubleValue = 0
        backThighSlider.doubleValue = 0
        backCalfSlider.doubleValue = 0
        frontFootSlider.doubleValue = 0
        backFootSlider.doubleValue = 0
        heightText.stringValue = "0.0"
        durText.stringValue = "0.0"
        valArray[currentIdx] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        timeArray[currentIdx] = 0
        anchorIsFrontFoots[currentIdx] = false
        human.setAction(bodyRot: 0, headRot: 0, frontArmRot: 0, backArmRot: 0, frontHandRot: 0, backHandRot: 0, frontThighRot: 0, backThighRot: 0, frontCalfRot: 0, backCalfRot: 0, frontFootRot: 0, backFootRot: 0, yOffset: 0)
    }
    var actionStartTime: Date = Date()
    @IBAction func play(_ sender: Any) {
        if human.hasActions() {
            human.removeAllActions()
        } else {
            if timeArray.first! > 0 {
                let action = HumanAction(specs: valArray, durs: timeArray, shouldRepeat: shouldRepeat, anchorIsFrontFoots: anchorIsFrontFoots)
                actionStartTime = Date()
                human.runAction(action)
            }
        }
    }
    @IBAction func addAction(_ sender: Any) {
        HumanAction.addAction(actionStr: actionNameField.stringValue + "\n" + actionTextField.stringValue)
        loadList()
    }
    @IBAction func deleteAction(_ sender: Any) {
        HumanAction.deleteAction(name: actionNameField.stringValue.trimmingCharacters(in: .whitespacesAndNewlines))
        loadList()
    }
    @IBAction func saveToDesktop(_ sender: Any) {
        HumanAction.saveToDesktop()
    }
    @IBAction func onEditName(_ sender: NSTextField) {
        let nameTitle = sender.stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if (pickerData.index(of: nameTitle) != nil) && (nameTitle != "") {
            addButton.title = "更新此动作"
            deleteButton.isEnabled = true
        } else {
            addButton.title = "添加此动作"
            deleteButton.isEnabled = false
        }
    }
    var exportActionStr: String = "new_action"
    @IBAction func export(_ sender: Any) {
        let specsString = valArray.map {"\($0.map {"\(round($0 * 1000) / 1000)"}.joined(separator: " "))"}.joined(separator: "  ")
        let dursString = timeArray.map {"\(round($0 * 1000) / 1000)"}.joined(separator: " ")
        let aiffsString = anchorIsFrontFoots[0..<valArray.count].map {"\($0)"}.joined(separator: " ")
        actionTextField.stringValue = "\(specsString)\n\(dursString)\n\(shouldRepeat)\n\(aiffsString)\n0"
        actionNameField.stringValue = exportActionStr
        onEditName(actionNameField)
    }
    
    func setElementsToVals(_ idx: Int = -1) {
        var index = currentIdx
        if idx >= 0 {
            index = idx
        }
        headSlider.doubleValue = Double(valArray[index][0])
        bodySlider.doubleValue = Double(valArray[index][1])
        frontArmSlider.doubleValue = Double(valArray[index][2])
        frontHandSlider.doubleValue = Double(valArray[index][3])
        backArmSlider.doubleValue = Double(valArray[index][4])
        backHandSlider.doubleValue = Double(valArray[index][5])
        frontThighSlider.doubleValue = Double(valArray[index][6])
        frontCalfSlider.doubleValue = Double(valArray[index][7])
        backThighSlider.doubleValue = Double(valArray[index][8])
        backCalfSlider.doubleValue = Double(valArray[index][9])
        frontFootSlider.doubleValue = Double(valArray[index][10])
        backFootSlider.doubleValue = Double(valArray[index][11])
        heightText.stringValue = "\(valArray[index][12])"
        durText.stringValue = "\(timeArray[index])"
        anchorIsFrontFoot = anchorIsFrontFoots[index]
        human.setAction(bodyRot: CGFloat(valArray[index][1]), headRot: CGFloat(valArray[index][0]), frontArmRot: CGFloat(valArray[index][2]), backArmRot: CGFloat(valArray[index][4]), frontHandRot: CGFloat(valArray[index][3]), backHandRot: CGFloat(valArray[index][5]), frontThighRot: CGFloat(valArray[index][6]), backThighRot: CGFloat(valArray[index][8]), frontCalfRot: CGFloat(valArray[index][7]), backCalfRot: CGFloat(valArray[index][9]), frontFootRot: CGFloat(valArray[index][10]), backFootRot: CGFloat(valArray[index][11]), yOffset: CGFloat(valArray[index][12]))
    }
    
    var originalAction: HumanAction? = nil
    func checkOut(action: HumanAction? = nil) {
        originalAction = action
        if let _action = action {
            self.valArray = _action.actionPoints
            self.timeArray = _action.durs
            self.anchorIsFrontFoots = _action.anchorIsFrontFoots
            self.shouldRepeat = _action.shouldRepeat
        }
        setElementsToVals()
    }
    func checkOut(action: String) {
        checkOut(action: HumanAction.actions[action])
    }
    @IBAction func equipFrontHandWeapon(_ sender: Any) {
        if human.frontHandWeapon == nil {
            human.frontHandWeapon = Weapon(Temp_blade_combined())
        } else {
            human.frontHandWeapon = nil
        }
    }
    @IBAction func equipBackHandWeapon(_ sender: Any) {
        if human.backHandWeapon == nil {
            human.backHandWeapon = Weapon(Temp_blade_combined())
        } else {
            human.backHandWeapon = nil
        }
    }
    func update() {
        if human.hasActions() {
            time = (Date().timeIntervalSince(actionStartTime) * human.actionSpeed).truncatingRemainder(dividingBy: totalTime)
        }
    }
    
    var pickerData: [String] = []
    func loadList() {
        pickerData = Array(HumanAction.actions.keys).sorted(by: {$0 < $1})
        picker.removeAllItems()
        picker.addItem(withTitle: "new_action")
        picker.addItems(withTitles: pickerData)
    }
    @IBAction func readAction(_ sender: Any) {
        currentIdx = 0
        exportActionStr = picker.titleOfSelectedItem!
        checkOut(action: exportActionStr)
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
                (scene as! GameScene).vc = self
                
                loadList()
                onEditName(actionNameField)
                
            }
            
            view.ignoresSiblingOrder = true
        }
    }
}

