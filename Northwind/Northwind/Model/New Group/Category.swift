//
//  Category+CoreDataClass.swift
//  Northwind
//
//  Created by Maciej Łobodziński on 15/12/2017.
//
//

import Foundation
import CoreData

@objc(Category)
public class Category: NWObject {

}

extension Category: PickerModelDescription {

    static func pickerConfiguration() -> PickerConfiguration {
        return PickerConfiguration(entityName: "Category",
                                   sortKey: "categoryName",
                                   descriptionKey: "categoryName")
    }
    
}

