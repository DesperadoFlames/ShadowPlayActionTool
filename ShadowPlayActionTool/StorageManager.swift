//
//  StorageManager.swift
//  ShadowPlay
//
//  Created by Desperado on 2/15/29 H.
//  Copyright © 29 Heisei Des. All rights reserved.
//

import Foundation

class StorageManager {
    private static var _shared: StorageManager? = nil
    static var shared: StorageManager {
        return _shared!
    }
    
    static let mainPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.allDomainsMask, true)[0]
    let playerPath = mainPath + "/Player.plist"
    
    init() {
        StorageManager._shared = self
    }
    
    func savePlayerData() {
        NSKeyedArchiver.archiveRootObject(Player.shared, toFile: playerPath)
    }
    
    func getPlayerData() -> Player? {
        if let player = NSKeyedUnarchiver.unarchiveObject(withFile: playerPath) as? Player {
            return player
        } else {
            return nil
        }
    }
    
    func saveData() {
        savePlayerData()
    }
}
