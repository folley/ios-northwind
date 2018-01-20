//
//  CustomerDemographic+CoreDataClass.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData

@objc(CustomerDemographic)
public class CustomerDemographic: NWObject {

}

extension CustomerDemographic {
    static func listConfiguration() -> ListConfiguration {
        return ListConfiguration(entityName: "CustomerDemographic",
                                 sortKey: "objectID",
                                 titleKey: "objectID",
                                 priceKey: "objectID") // todo:
    }
    
}

extension CustomerDemographic: PickerModelDescription {
    
    static func pickerConfiguration() -> PickerConfiguration {
        return PickerConfiguration(entityName: "CustomerDemographic",
                                   sortKey: "objectID",
                                   descriptionKey: "objectID")
    }
    
}

extension CustomerDemographic: EditableItemConfiguration {
    typealias T = CustomerDemographic
    
    static func editConfigurationItems() -> [ItemEditConfiguration<CustomerDemographic>.Item] {
        let items: [ItemEditConfiguration<CustomerDemographic>.Item] = [
            
//            ItemEditConfiguration<CustomerDemographic>.Item(keyPath: \CustomerDemographic.customers,
//                                                            name: "Customers",
//                                                            writeKeyPath: "customers",
//                                                            customClass: nil)
            
        ]
        return items
    }
    
}
