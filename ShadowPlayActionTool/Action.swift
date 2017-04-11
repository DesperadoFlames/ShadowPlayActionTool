//
//  Actions.swift
//  ShadowPlay
//
//  Created by Desperado on 3/2/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation
import SpriteKit

class HumanAction {
    let actionPoints: [[CGFloat]]
    let durs: [TimeInterval]
    let shouldRepeat: Bool
    let anchorIsFrontFoots: [Bool]
    
    init(specs: [[CGFloat]], durs: [TimeInterval], shouldRepeat: Bool, anchorIsFrontFoots: [Bool]) {
        self.actionPoints = specs
        self.durs = durs
        self.shouldRepeat = shouldRepeat
        self.anchorIsFrontFoots = anchorIsFrontFoots
    }
    
    static var actions: Dictionary<String, HumanAction> = readFile()
    
    static func readFile() -> Dictionary<String, HumanAction> {
        let path = Bundle.main.path(forResource: "actions", ofType: "txt")!
        do {
            let data: [(String, HumanAction)] = try String(contentsOfFile: path, encoding: .utf8).components(separatedBy: "\n\n").map({
                let elements = $0.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
                return (elements[0], HumanAction(specs: elements[1].components(separatedBy: "  ").map { $0.components(separatedBy: " ").map {CGFloat(Double($0)!)} }, durs: elements[2].components(separatedBy: " ").map {Double($0)!}, shouldRepeat: Bool(elements[3])!, anchorIsFrontFoots: elements[4].components(separatedBy: " ").map {Bool($0)!}))
            })
            return Dictionary(elements: data)
        } catch {
            fatalError("Error reading actions")
        }
    }
    
    static func addAction(actionStr: String) {
        let str = actionStr.trimmingCharacters(in: .whitespacesAndNewlines)
        if str.components(separatedBy: "\n").count != 6 { return }
        let path = Bundle.main.path(forResource: "actions", ofType: "txt")!
        do {
            var data: [String] = try String(contentsOfFile: path, encoding: .utf8).components(separatedBy: "\n\n")
            data = data.filter {
                let item = $0.trimmingCharacters(in: .whitespacesAndNewlines)
                return item != "" && item.components(separatedBy: "\n")[0] != actionStr.components(separatedBy: "\n")[0]
            }
            data.append(actionStr.trimmingCharacters(in: .whitespacesAndNewlines))
            try data.joined(separator: "\n\n").write(toFile: path, atomically: false, encoding: .ascii)
            actions = readFile()
        } catch {
            fatalError("Error reading actions")
        }
    }

    static func deleteAction(name: String) {
        if name.trimmingCharacters(in: .whitespacesAndNewlines) == "" { return }
        let path = Bundle.main.path(forResource: "actions", ofType: "txt")!
        do {
            var data: [String] = try String(contentsOfFile: path, encoding: .utf8).components(separatedBy: "\n\n")
            data = data.filter {
                let item = $0.trimmingCharacters(in: .whitespacesAndNewlines)
                return item != "" && item.components(separatedBy: "\n")[0] != name.components(separatedBy: "\n")[0]
            }
            try data.joined(separator: "\n\n").write(toFile: path, atomically: false, encoding: .ascii)
            actions = readFile()
        } catch {
            fatalError("Error reading actions")
        }
    }
    
    static func saveToDesktop() {
        let paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
        if let desktopPath = paths.first {
            let path = Bundle.main.path(forResource: "actions", ofType: "txt")!
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                try data.write(toFile: desktopPath + "/actions.txt", atomically: true, encoding: .ascii)
            } catch {
                fatalError("Error reading actions")
            }
        }
    }
}
