//
//  CreatorViewController.swift
//  TaskBoard
//
//  Created by Prince Alvin Yusuf on 09/04/20.
//  Copyright © 2020 Prince Alvin Yusuf. All rights reserved.
//

import UIKit

class CreatorViewController: UIViewController {
    
    //MARK:- Types
    
    enum DataPassage {
        case complete
        case incomplete
        case new
    }
    
    //MARK:- Storyboard
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    @IBOutlet weak var taskDatePicker: UIDatePicker!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    
    //MARK:- Variables
    let imagePicker = UIImagePickerController()
    var dataPassage: DataPassage = .complete
    var selectedTask: Task? = nil
    var selectedTaskIndex: Int? = nil
    let dateFormatter = DateFormatter()
    
    //MARK:- Methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDescriptionTextView.layer.borderWidth = 1.0
        titleTextField.layer.borderWidth = 1.0
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // setupView, does the same thing that it did in the InfoViewController. Just sets up the elements that are
    // displayed
    func setupView() {
        taskDatePicker.minimumDate = Date()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        if dataPassage != .new {
            guard let selectedTask = selectedTask else {
                return
            }
            titleTextField.text = selectedTask.title
            taskDescriptionTextView.text = selectedTask.taskDescription
            switch selectedTask.priority {
            case .normal:
                prioritySegmentedControl.selectedSegmentIndex = 0
            case .high:
                prioritySegmentedControl.selectedSegmentIndex = 1
            case .extreme:
                prioritySegmentedControl.selectedSegmentIndex = 2
            }
            if selectedTask.dueDate != "" {
                taskDatePicker.date = dateFormatter.date(from: selectedTask.dueDate)!
            }
            
        } else {
            return
        }
        
        
    }
    
    // This is the creation button. Takes information in the fields and creates a new task.
    @IBAction func buttonDone(_ sender: Any) {
        
        if titleTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "You must at least have a task name!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Return", style: .default, handler: { action in
            }))
            self.present(alert, animated: true, completion: nil)
            return
        } else {
            createTask()
        }
    }
    
    func createTask() {
        let priority: String
        let taskDate = dateFormatter.string(from: taskDatePicker.date)
        switch prioritySegmentedControl.selectedSegmentIndex {
        case 0:
            priority = "normal"
        case 1:
            priority = "high"
        case 2:
            priority = "extreme"
        default:
            priority = "normal"
        }
        switch dataPassage {
            
        case .complete:
            let taskInMain = TaskManager.sharedInstance.getTaskArray().firstIndex(of: selectedTask!)
            TaskManager.sharedInstance.removeTask(at: taskInMain!)
            let task = Task(title: titleTextField.text!, description: taskDescriptionTextView.text, dueDate: taskDate, priority: priority, finished: true)
            TaskManager.sharedInstance.addToArrayAt(task: task, index: taskInMain!)
            
            performSegue(withIdentifier: "backToTaskView", sender: self)
        case .incomplete:
            let taskInMain = TaskManager.sharedInstance.getTaskArray().firstIndex(of: selectedTask!)
            TaskManager.sharedInstance.removeTask(at: taskInMain!)
            let task = Task(title: titleTextField.text!, description: taskDescriptionTextView.text, dueDate: taskDate, priority: priority, finished: false)
            TaskManager.sharedInstance.addToArrayAt(task: task, index: taskInMain!)
            performSegue(withIdentifier: "backToTaskView", sender: self)
        case .new:
            let task = Task(title: titleTextField.text!, description: taskDescriptionTextView.text, dueDate: taskDate, priority: priority, finished: false)
            TaskManager.sharedInstance.addToArray(taskToAdd: task)
            performSegue(withIdentifier: "backToTaskView", sender: self)
        }
        
        
    }
    
}

extension UIViewController {

    @objc func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
