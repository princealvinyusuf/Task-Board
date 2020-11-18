//
//  TaskViewController.swift
//  TaskBoard
//
//  Created by Prince Alvin Yusuf on 09/04/20.
//  Copyright © 2020 Prince Alvin Yusuf. All rights reserved.
//

import UIKit
import BonsaiController

protocol TaskDisplayDelegate: class {
    
    func changeView(index: Int)
    func reloadView()
}

class TaskViewController: UIViewController {
    
    //MARK:- Types

    
    //MARK:- Variables
    var selectedTask: Task? = nil
    var selectedTaskIndex: Int? = nil
    var constructedArray: [[Task]] = [[]]
    weak var taskDisplayDelegate: TaskDisplayDelegate?
    
    //MARK:- Storyboard

    @IBOutlet weak var childView: UIView!
    @IBOutlet weak var taskSegmentedControl: UISegmentedControl!
    
    //MARK:- Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
     // Whenever we change the segmented control, we will also tell the delegate to change its view to the
    // corresponding value.
    @IBAction func segmentedControlChanged(_ sender: Any) {
        switch taskSegmentedControl.selectedSegmentIndex {
        case 0:
            taskDisplayDelegate?.changeView(index: 0)
        case 1:
            taskDisplayDelegate?.changeView(index: 1)
        case 2:
            taskDisplayDelegate?.changeView(index: 2)
            
        default:
            print("~ Pay")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        taskSegmentedControl.selectedSegmentIndex = 0
        
    }
    
        
    @IBAction func unwindToTaskView(segue:UIStoryboardSegue) { }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is TaskDisplayViewController
        {
            guard let taskDisplayViewController = segue.destination as? TaskDisplayViewController else {
                print("error")
                return
            }
            taskDisplayDelegate = taskDisplayViewController
        }
        if segue.destination is CreatorViewController {
            guard let creatorViewController = segue.destination as? CreatorViewController else {
                return
            }
            creatorViewController.dataPassage = .new
        }
        
        if segue.destination is AboutController {
                   segue.destination.transitioningDelegate = self
                   segue.destination.modalPresentationStyle = .custom
               }
        
        if segue.destination is CreatorViewController {
            segue.destination.transitioningDelegate = self
            segue.destination.modalPresentationStyle = .custom
        }
        
    }
    
    
    
}

extension TaskViewController: BonsaiControllerDelegate {
    
    // return the frame of your Bonsai View Controller
    func frameOfPresentedView(in containerViewFrame: CGRect) -> CGRect {
        
        return CGRect(origin: CGPoint(x: 0, y: containerViewFrame.height / 7.7), size: CGSize(width: containerViewFrame.width, height: containerViewFrame.height / (4/4)))
    }
    
    // return a Bonsai Controller with SlideIn or Bubble transition animator
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {

        return BonsaiController(fromDirection: .bottom, backgroundColor: UIColor(white: 0, alpha: 0.5), presentedViewController: presented, delegate: self)

    }
}
