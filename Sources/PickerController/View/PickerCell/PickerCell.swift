//
//  EZYPickerCell.swift
//  EZYPickerView
//
//  Created by Shashank Pali on 08/03/22.
//

import UIKit

final class PickerCell: UITableViewCell {
    
    func setup(using model: PickerModel) {
        textLabel?.text = model.title
        textLabel?.font = UIFont.systemFont(ofSize: 20)
        textLabel?.numberOfLines = 0
        textLabel?.lineBreakMode = .byWordWrapping
        textLabel?.textColor = .darkGray
        accessoryType = model.isSelected ? .checkmark : .none
        //
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }

}
