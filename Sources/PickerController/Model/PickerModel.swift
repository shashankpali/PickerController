//
//  EZYPickerModel.swift
//  EZYPickerView
//
//  Created by Shashank Pali on 07/03/22.
//

import Foundation

class PickerModel {
    var title : String
    var isSelected : Bool
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}
