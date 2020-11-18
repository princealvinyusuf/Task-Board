//
//  TaskManager.swift
//  TaskBoard
//
//  Created by Prince Alvin Yusuf on 09/04/20.
//  Copyright © 2020 Prince Alvin Yusuf. All rights reserved.
//

import Foundation

class TaskManager {
    // The TaskManager handles everything with the taskArray, from removing and adding tasks to finishing tasks
    
    
    //MARK:- Types
    enum SelectedArray {
        case complete
        case incomplete
    }
    
    
    //MARK:- Variables
    static let sharedInstance = TaskManager()
    
    private var selectedArray: SelectedArray? = nil
    private var taskArray: [Task] = []
    
    var count: Int {
        return taskArray.count
    }
    
    
    
    //MARK:- Methods
    
    private init () { }
    
    func setArray(to newArray: [Task]) {
        taskArray = newArray
    }
    
    func addToArray(taskToAdd: Task) {
        print("adding a task")
        taskArray.append(taskToAdd)
        DataManager.sharedInstance.saveArray(array: taskArray)
    }
    
    func addToArrayAt(task: Task, index: Int) {
        taskArray.insert(task, at: index)
         DataManager.sharedInstance.saveArray(array: taskArray)
        
    }
    
    //MARK:- Getters and setters
    
    
    func getTaskArray() -> [Task] {
        return taskArray
    }
    
    func removeTask(at index: Int) {
        taskArray.remove(at: index)
         DataManager.sharedInstance.saveArray(array: taskArray)
    }
    
    func finishTask(index: Int) {
        taskArray[index].finished = true
         DataManager.sharedInstance.saveArray(array: taskArray)
    }
    func unfinishTask(index: Int) {
        taskArray[index].finished = false
         DataManager.sharedInstance.saveArray(array: taskArray)
    }
    
}
