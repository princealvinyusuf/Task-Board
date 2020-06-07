//
//  DataManager.swift
//  TaskBoard
//
//  Created by Prince Alvin Yusuf on 09/04/20.
//  Copyright © 2020 Prince Alvin Yusuf. All rights reserved.
//

import Foundation

class DataManager {
    // The DataManager is responsible for using NSDefaults to save information and load information.
    
 static let sharedInstance = DataManager()
    

    
    private init () { }
    
     func saveArray(array: [Task]) {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: array)
        UserDefaults.standard.set(savedData, forKey: "taskArray")
    }
     func loadArray() -> [Task]? {
        guard let savedArray = UserDefaults.standard.value(forKey: "taskArray") else {
            print("Failed to load.")
            return nil
        }
        let array = NSKeyedUnarchiver.unarchiveObject(with: savedArray as! Data)
        return array as? [Task]
    }
    
    func savePassword(password: String) {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: password)
        UserDefaults.standard.set(savedData, forKey: "password")
    }
    
    func loadPassword() -> String? {
        guard let savedPassword = UserDefaults.standard.value(forKey: "password") else {
            print("failed to load")
            return nil
        }
        let password = NSKeyedUnarchiver.unarchiveObject(with: savedPassword as! Data)
        return password as? String
    }
    
    func saveUsername(username: String) {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: username)
        UserDefaults.standard.set(savedData, forKey: "username")
    }
    
    func loadUsername() -> String? {
        guard let savedUsername = UserDefaults.standard.value(forKey: "username") else {
            print("failed to load")
            return nil
        }
        let username = NSKeyedUnarchiver.unarchiveObject(with: savedUsername as! Data)
        return username as? String
    }
    
    
}
