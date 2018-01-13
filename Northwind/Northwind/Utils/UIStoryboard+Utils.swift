//
//  UIStoryboard+Utils.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//

import UIKit

extension UIStoryboard {
    
    class func pickerVC() -> ObjectPickerViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PickerVC") as! ObjectPickerViewController
        return vc
    }
    
}
