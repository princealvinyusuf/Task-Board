//
//  TaskCell.swift
//  TaskBoard
//
//  Created by Prince Alvin Yusuf on 09/04/20.
//  Copyright © 2020 Prince Alvin Yusuf. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var statusIndicator: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var taskImageView: UIImageView!
    
    
    // Sets up the tableView cell based on the task that is passed from the indexPath.row
    func setup(task: Task) {
        titleLabel.text = task.title
        descriptionLabel.text = task.taskDescription
        if task.dueDate != "" {
            dueDateLabel.text = task.dueDate
        } else {
            dueDateLabel.text = ""
        }
        if task.finished == false {
            statusIndicator.backgroundColor = #colorLiteral(red: 1, green: 0.462745098, blue: 0.4588235294, alpha: 1)
        } else {
            statusIndicator.backgroundColor = #colorLiteral(red: 0.3333333333, green: 0.937254902, blue: 0.768627451, alpha: 1)
        }
    }
    
}
