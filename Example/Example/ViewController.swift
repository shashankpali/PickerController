//
//  ViewController.swift
//  Example
//
//  Created by Shashank Pali on 21/03/22.
//

import UIKit
import PickerController

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.accessibilityIdentifier == "country" {
            
            var countries: [String] = []
            for code in NSLocale.isoCountryCodes  {
                let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
                countries.append(name)
            }
            PickerController.showPicker(forItems: countries, title: "Select country", on: self) { res in
                textField.text = res[0]
            }
            
        } else if textField.accessibilityIdentifier == "carBrands" {
            
            PickerController.showMultiPicker(forItems: ["Ford", "Honda", "Kia", "BMW", "MG", "Hyundai", "Volkswagen", "Toyota"], selectedItem: textField.text?.count ?? 0 > 0 ? textField.text?.components(separatedBy: ", ") : nil, title: "Select Car Brands", on: self) { res in
                textField.text = res.joined(separator: ", ")
            }
            
        }else {
            return true
        }
        return false
    }


}

