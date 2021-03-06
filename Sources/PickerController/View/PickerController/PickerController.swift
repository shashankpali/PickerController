//
//  EZYPickerController.swift
//  EZYPickerView
//
//  Created by Shashank Pali on 07/03/22.
//

import UIKit

final public class PickerController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var pickerTableView: UITableView!
    @IBOutlet weak var backgroundBtn: UIButton!
    //
    @IBOutlet private weak var searchHeightConstant: NSLayoutConstraint!
    @IBOutlet private weak var doneHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var pickerBottomConstant: NSLayoutConstraint!
    //
    private var viewModel : PickerViewModel!
    private var dataSource : [PickerModel]?
    private var pickerTitle = ""
    private var multiSelect = true
    private var callback : (([String]) -> Void)?
    //
    private let cellIdentifer = String(describing: PickerCell.self)
    
    // MARK: - Usage methods
    
    @objc public static func showPicker(forItems: [String], title: String, on controller: UIViewController, callback: @escaping ([String]) -> Void) {
        PickerController.setupPicker(forItems: forItems, selectedItem: nil, title: title, multiSelect: false, on: controller, callback: callback)
    }
    
    @objc public static func showMultiPicker(forItems: [String], selectedItem: [String]?, title: String, on controller: UIViewController, callback: @escaping ([String]) -> Void) {
        PickerController.setupPicker(forItems: forItems, selectedItem: selectedItem, title: title, multiSelect: true, on: controller, callback: callback)
    }
    
    // MARK: - Common initializer
    
    private static func setupPicker(forItems: [String], selectedItem: [String]?, title: String, multiSelect: Bool, on controller: UIViewController, callback: @escaping ([String]) -> Void) {
        
        let picker = PickerController(nibName: String(describing: PickerController.self), bundle: .module)
        
        picker.viewModel = PickerViewModel.init(forItems: forItems, selectedItems: multiSelect ? selectedItem : nil)
        picker.viewModel.delegate = picker
        picker.dataSource = picker.viewModel.getDataSource()
        picker.multiSelect = multiSelect
        picker.callback = callback
        picker.pickerTitle = title
        
        picker.modalPresentationStyle = .overCurrentContext
        controller.present(picker, animated: false, completion: nil)
    }
    
    // MARK: - Controller life cycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        pickerTableView.register(PickerCell.self, forCellReuseIdentifier: cellIdentifer)
        titleLabel.text = pickerTitle
        setupUI()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        picker(show: true)
    }
    
    private func setupUI() {
        searchHeightConstant.constant = dataSource?.count ?? 0 > 7 ? searchHeightConstant.constant : 0
        doneHeightConstant.constant = multiSelect ? doneHeightConstant.constant : 0
        backgroundBtn.setTitle("", for: .normal)
    }
    
    private func picker(show: Bool) {
        pickerBottomConstant.constant = show ? 10.0 : -540.0
        UIView.animate(withDuration: 0.3) {
            self.backgroundBtn.backgroundColor = show ? UIColor.init(white: 0, alpha: 0.4) : UIColor.clear
            self.view.layoutIfNeeded()
        } completion: { success in
            guard show == false else {return}
            self.callback = nil
            self.dismiss(animated: false, completion: nil)
        }
    }
    
}

extension PickerController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! PickerCell
        if let model = dataSource?[indexPath.row] {
            cell.setup(using: model)
        }
        return cell
    }
    
}

// MARK: - User action

extension PickerController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.change(forIdx: indexPath.row)
        if !multiSelect {
            userSelectedItems()
        }
    }
    
    private func userSelectedItems() {
        if let block = callback {
            block(viewModel.getSelectedItem())
        }
        dismissPicker(UIButton())
    }
    
    @IBAction private func doneTapped(_ sender: UIButton) {
        userSelectedItems()
    }
    
    @IBAction private func dismissPicker(_ sender: UIButton) {
        picker(show: false)
    }
    
}

extension PickerController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter(using: searchText)
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        pickerBottomConstant.constant = 10.0
        animate(withDuration: 0.2)
        searchBar.resignFirstResponder()
    }
    
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        pickerBottomConstant.constant = pickerTableView.bounds.height/2.5
        animate(withDuration: 0.3)
        return true
    }
    
    private func animate(withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
}

// MARK: - Reload

extension PickerController: PickerViewModelDelegate {
    
    func didReceivedUpdated(dataSource: [PickerModel]) {
        self.dataSource = dataSource
        pickerTableView.reloadData()
    }
    
}
