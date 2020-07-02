//
//  ListTableViewCell.swift
//  ToDo List
//
//  Created by Chris Burdick on 7/2/20.
//  Copyright © 2020 Chris Burdick. All rights reserved.
//

import UIKit

protocol listTableViewCellDelegate: class {
    func checkBoxToggle(sender: ListTableViewCell)
}

class ListTableViewCell: UITableViewCell {
    
    weak var delegate: listTableViewCellDelegate?
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func checkToggled(_ sender: UIButton) {
        delegate?.checkBoxToggle(sender: self)
    }
}
