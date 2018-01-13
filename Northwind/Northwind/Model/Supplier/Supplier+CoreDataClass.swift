//
//  Supplier+CoreDataClass.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData

@objc(Supplier)
public class Supplier: NSManagedObject {

}

extension Supplier: PickerModelDescription {
    
    static func pickerConfiguration() -> PickerConfiguration {
        return PickerConfiguration(entityName: "Supplier",
                                   sortKey: "companyName",
                                   descriptionKey: "companyName")
    }
    
}

