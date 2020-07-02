//
//  ToDoDetailTableViewController.swift
//  ToDo List
//
//  Created by Chris Burdick on 6/29/20.
//  Copyright © 2020 Chris Burdick. All rights reserved.
//

import UIKit

private let dateFormatter: DateFormatter = {
    print("created a date formatter")
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .short
    return dateFormatter
} ()
// the open/close parentheses makes this act as a function

class ToDoDetailTableViewController: UITableViewController {
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteView: UITextView!
    @IBOutlet weak var reminderSwitch: UISwitch!
    @IBOutlet weak var dateLabel: UILabel!
    
    var toDoItem: ToDoItem!
    
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesTextViewIndexPath = IndexPath(row: 0, section: 2)
    let notesRowHeight: CGFloat = 200
    let defaultRowHeight: CGFloat = 44
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toDoItem == nil {
            toDoItem = ToDoItem(name: "", date: Date().addingTimeInterval(24*60*60), notes: "", reminderSet: false, completed: false)
        }
        updateUserInterface()
    }
    
    func updateUserInterface() {
        nameField.text = toDoItem.name
        datePicker.date = toDoItem.date
        noteView.text = toDoItem.notes
        reminderSwitch.isOn = toDoItem.reminderSet
        // ternary operator -> same thing as an if statement
        dateLabel.textColor = (reminderSwitch.isOn ? .black : .gray)
        dateLabel.text = dateFormatter.string(from: toDoItem.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDoItem = ToDoItem(name: nameField.text!, date: datePicker.date, notes: noteView.text, reminderSet: reminderSwitch.isOn, completed: toDoItem.completed)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func reminderSwitchChanged(_ sender: UISwitch) {
        dateLabel.textColor = (reminderSwitch.isOn ? .black : .gray)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        dateLabel.text = dateFormatter.string(from: sender.date)
    }
}

extension ToDoDetailTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return reminderSwitch.isOn ? datePicker.frame.height : 0
        case notesTextViewIndexPath:
            return notesRowHeight
        default:
            return defaultRowHeight
        }
    }
}
