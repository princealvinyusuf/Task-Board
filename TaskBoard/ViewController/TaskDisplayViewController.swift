//
//  TaskDisplayViewController.swift
//  TaskBoard
//
//  Created by Prince Alvin Yusuf on 09/04/20.
//  Copyright © 2020 Prince Alvin Yusuf. All rights reserved.
//

import UIKit
import BonsaiController

class TaskDisplayViewController: UIViewController, TaskDisplayDelegate {
    
    //MARK:- Types
    enum CurrentView {
        case all
        case incomplete
        case complete
    }
    
    //MARK:- Variables
    var currentView: CurrentView = .all
    var constructedArray: [[Task]] = [[]]
    var cellNumber = 1
    var selectedTask: Task?
    var selectedTaskIndex: Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Methods
    
    func reloadView() {
        tableView.reloadData()
    }
    
    // changeView is called by delegation through the TaskViewController, It essentially just makes the display
    // show a filtered array depending on what value was selected in the TaskView.
    func changeView(index: Int) {
        switch index {
        case 0:
            currentView = .all
            constructedArray = [TaskManager.sharedInstance.getTaskArray().filter( {
                $0.priority == .extreme
            }), TaskManager.sharedInstance.getTaskArray().filter( {
                $0.priority == .high
            }), TaskManager.sharedInstance.getTaskArray().filter( {
                $0.priority == .normal
            })]
            tableView.reloadData()
            
            
        case 1:
            currentView = .incomplete
            constructedArray = [TaskManager.sharedInstance.getTaskArray().filter( {
                
                $0.priority == .extreme && $0.finished == false
                
            }), TaskManager.sharedInstance.getTaskArray().filter( {
                
                $0.priority == .high && $0.finished == false
                
                
                
            }), TaskManager.sharedInstance.getTaskArray().filter( {
                
                $0.priority == .normal && $0.finished == false
                
            })]
            tableView.reloadData()
        case 2:
            currentView = .complete
            constructedArray = [TaskManager.sharedInstance.getTaskArray().filter( {
                $0.priority == .extreme && $0.finished == true
                
                
            }), TaskManager.sharedInstance.getTaskArray().filter( {
                
                $0.priority == .high && $0.finished == true
                
                
            }), TaskManager.sharedInstance.getTaskArray().filter( {
                
                $0.priority == .normal && $0.finished == true
                
            })]
            tableView.reloadData()
        default:
            print("error")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        changeView(index: 0)
        guard let taskArray = DataManager.sharedInstance.loadArray() else {
            // Load the taskArray data if it existsl
            return
        }
        TaskManager.sharedInstance.setArray(to: taskArray)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeView(index: 0)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is InfoViewController
        {
            guard let infoViewController = segue.destination as? InfoViewController else {
                print("error")
                return
            }
            switch currentView {
                // The dataPassage variable is used to tell the infoViewController how it should react to the
            // data we are passing it.
            case .all:
                if selectedTask?.finished == false {
                    infoViewController.dataPassage = .incomplete
                } else {
                    infoViewController.dataPassage = .complete
                }
            case .incomplete:
                infoViewController.dataPassage = .incomplete
            case .complete:
                infoViewController.dataPassage = .complete
            }
            infoViewController.selectedTask = selectedTask
            infoViewController.selectedTaskIndex = selectedTaskIndex
        }
        
        if segue.destination is InfoViewController {
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
    }
    
}



extension TaskDisplayViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    // Normal table creations.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Task") as! TaskCell
        cell.setup(task: constructedArray[indexPath.section][indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTask = constructedArray[indexPath.section][indexPath.row]
        selectedTaskIndex = TaskManager.sharedInstance.getTaskArray().firstIndex(of: selectedTask!)
        performSegue(withIdentifier: "toInfo", sender: self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return constructedArray[0].count
        case 1:
            return constructedArray[1].count
        case 2:
            return constructedArray[2].count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return "EXTREME"
            }
        case 1:
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return "HIGH"
            }
        case 2:
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return "NORMAL"
            }
        default:
            return nil
        }
        return nil
    }
}

extension TaskDisplayViewController: BonsaiControllerDelegate {
    
    // return the frame of your Bonsai View Controller
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 1.5), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/3)))
    }
    
    // return a Bonsai Controller with SlideIn or Bubble transition animator
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return BonsaiController(fromDirection: .bottom, backgroundColor: UIColor(white: 0, alpha: 0.5), presentedViewController: presented, delegate: self)
        
    }
}

