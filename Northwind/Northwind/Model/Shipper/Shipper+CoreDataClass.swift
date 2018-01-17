//
//  Shipper+CoreDataClass.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData

@objc(Shipper)
public class Shipper: NWObject {

}

extension Shipper {
    static func listConfiguration() -> ListConfiguration {
        return ListConfiguration(entityName: "Shipper",
                                 sortKey: "companyName",
                                 titleKey: "companyName")
    }
    
}

extension Shipper: PickerModelDescription {
    
    static func pickerConfiguration() -> PickerConfiguration {
        return PickerConfiguration(entityName: "Shipper",
                                   sortKey: "companyName",
                                   descriptionKey: "companyName")
    }
    
}

extension Shipper: EditableItemConfiguration {
    typealias T = Shipper
    
    static func editConfigurationItems() -> [ItemEditConfiguration<Shipper>.Item] {
        let items: [ItemEditConfiguration<Shipper>.Item] = [
            
            ItemEditConfiguration<Shipper>.Item(keyPath: \Shipper.companyName,
                                                name: "Company Name"),
            ItemEditConfiguration<Shipper>.Item(keyPath: \Shipper.phone,
                                                name: "Phone"),
//            ItemEditConfiguration<Shipper>.Item(keyPath: \Shipper.orders,
//                                                name: "Orders",
//                                                writeKeyPath: "orders",
//                                                customClass: nil)
            
        ]
        return items
    }
    
}
