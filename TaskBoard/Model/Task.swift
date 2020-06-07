//
//  Task.swift
//  TaskBoard
//
//  Created by Prince Alvin Yusuf on 09/04/20.
//  Copyright © 2020 Prince Alvin Yusuf. All rights reserved.
//

import UIKit

class Task: NSObject, NSCoding {
    // Basic Task object, The main object of this program, but it isn't very complex.
    
    
    //MARK:- Types
    enum Priority:String {
        case normal = "normal"
        case high = "high"
        case extreme = "extreme"
    }
    
    
    //MARK:- Variables
    var finished: Bool
    var priority: Priority
    var title: String
    var taskDescription: String
    var dueDate: String
    var image: UIImage?
    
    //MARK:- Methods
    
    init(title: String, description: String, priority: Priority) {
        self.title = title
        self.taskDescription = description
        self.dueDate = ""
        self.image = UIImage(named: "nil")
        self.priority = priority // This init is only here because I use it for debugging purposes
        self.finished = false
    }
    
    init(title: String, description: String, dueDate: String, priority: String, finished: Bool) {
        self.title = title
        self.taskDescription = description
        self.dueDate = dueDate
        self.priority = Priority(rawValue: priority)!
        self.finished = finished
    }
    
    //MARK:- NSCODING Methods
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.taskDescription, forKey: "taskDescription")
        aCoder.encode(self.dueDate, forKey: "dueDate")
        aCoder.encode(self.priority.rawValue, forKey: "priority")
        aCoder.encode(self.finished, forKey: "finished")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let title = aDecoder.decodeObject(forKey: "title") as! String?
        let description = aDecoder.decodeObject(forKey: "taskDescription") as! String?
        let dueDate = aDecoder.decodeObject(forKey: "dueDate")as! String?
        let priority = aDecoder.decodeObject(forKey: "priority") as! String
        let finished = aDecoder.decodeBool(forKey: "finished")
            self.init(title: title!, description: description!, dueDate: dueDate!, priority: priority, finished: finished)
    }
    
    
    
    
}
