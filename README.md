# PickerController

`PickerController` helps you to present a picker on `ViewController`. This picker provide you **single selection** and **multiple selection** picker with **search functionality**. `PickerController` is easy to use and implement.  

# Swift Package

Just search for the `PickerController` in Package Dependencies or copy the below URL and paste it in it's serch field

***
```
https://github.com/shashankpali/PickerController
```

# Showcase
|       Single Selection        |                 Multiple Selection                |
|-------------------------------|---------------------------------------------------|
|![single](https://user-images.githubusercontent.com/11850361/159502342-546c0b3a-2e31-47f2-b696-3d6d299075ae.png)|![multiple](https://user-images.githubusercontent.com/11850361/159502410-95f39386-3303-46d4-b8f7-1566ed76f687.png)|

# Integration Method
#### For Single Selection
***
```Swift

var countries: [String] = []
            for code in NSLocale.isoCountryCodes  {
                let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
                countries.append(name)
            }
            
PickerController.showPicker(forItems: countries,
                                        title: "Select country",
                                        on: self) { res in print(res) }
```
#### For Multiple Selection
```Swift
let brands = ["MG", "Hyundai", "Volkswagen", "Ford", "Honda", "Kia", "BMW", "Toyota"]
let selectedItems = ["Ford", "Honda"]
            
PickerController.showMultiPicker(forItems: brands,
                                 selectedItem: selectedItems,
                                 title: "Select Car Brands",
                                 on: self) { res in print(res) }
```

# License

`PickerController` is available under the MIT license. See the LICENSE file for more info.
