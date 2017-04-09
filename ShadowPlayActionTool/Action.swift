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
                let elements = $0.components(separatedBy: .newlines)
                return (elements[0], HumanAction(specs: elements[1].components(separatedBy: "  ").map { $0.components(separatedBy: " ").map {CGFloat(Double($0)!)} }, durs: elements[2].components(separatedBy: " ").map {Double($0)!}, shouldRepeat: Bool(elements[3])!, anchorIsFrontFoots: elements[4].components(separatedBy: " ").map {Bool($0)!}))
            })
            return Dictionary(elements: data)
        } catch {
            fatalError("Error reading actions")
        }
    }
}
