//
//  ToDoItem.swift
//  ToDo List
//
//  Created by Chris Burdick on 6/30/20.
//  Copyright © 2020 Chris Burdick. All rights reserved.
//

import Foundation

struct ToDoItem: Codable {
    var name: String
    var date: Date
    var notes: String
    var reminderSet: Bool
    var notificationID: String?
    // notifications are optional, hence the question mark
    var completed: Bool
}
