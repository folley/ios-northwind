//
//  Product+CoreDataClass.swift
//  Northwind
//
//  Created by Maciej Łobodziński on 13/12/2017.
//
//

import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject {

}

extension Product: PickerModelDescription {
    
    static func pickerConfiguration() -> PickerConfiguration {
        return PickerConfiguration(entityName: "Product",
                                   sortKey: "productName",
                                   descriptionKey: "productName")
    }
    
}

