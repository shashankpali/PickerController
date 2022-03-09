//
//  EZYPickerViewModel.swift
//  EZYPickerView
//
//  Created by Shashank Pali on 07/03/22.
//

import Foundation

protocol PickerViewModelDelegate {
    func didReceivedUpdated(dataSource: [PickerModel])
}
    
final class PickerViewModel {
    
    private var dataSource : [PickerModel]
    private var filteredSource : [PickerModel]
    var delegate : PickerViewModelDelegate?
    
    init(forItems: [String], selectedItems: [String]?) {
        dataSource = forItems.map { item in
            PickerModel(title: item, isSelected: selectedItems?.contains(item) ?? false)
        }
        dataSource = PickerViewModel.sort(items: dataSource)
        filteredSource = dataSource
    }
    
    //MARK: - Usage Methods
     func filter(using pred: String) {
         filteredSource = pred.count > 0 ? dataSource.filter{$0.title.lowercased().contains(pred.lowercased())} : dataSource
         filteredSource = PickerViewModel.sort(items: filteredSource)
         
         delegate?.didReceivedUpdated(dataSource: filteredSource)
    }
    
    func change(forIdx: Int) {
        filteredSource[forIdx].isSelected = !filteredSource[forIdx].isSelected
        filteredSource = PickerViewModel.sort(items: filteredSource)
        
        delegate?.didReceivedUpdated(dataSource: filteredSource)
   }
    
    private static func sort(items: [PickerModel]) -> [PickerModel] {
        return items.sorted{$0.title < $1.title}.sorted{$0.isSelected && !$1.isSelected}
    }
    
    //MARK: Get Methods
    func getSelectedItem() -> [String] {
        return filteredSource.filter{$0.isSelected}.map{$0.title}
   }
    
    func getDataSource() -> [PickerModel] {
        return PickerViewModel.sort(items: filteredSource)
   }

}
