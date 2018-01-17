//
//  Customer+CoreDataClass.swift
//  Northwind
//
//  Created bySebastian Korzeniak
//
//

import Foundation
import CoreData

@objc(Customer)
public class Customer: NWObject {

}

extension Customer {
    static func listConfiguration() -> ListConfiguration {
        return ListConfiguration(entityName: "Customer",
                                 sortKey: "contactName",
                                 titleKey: "contactName")
    }
    
}

extension Customer: PickerModelDescription {
    
    static func pickerConfiguration() -> PickerConfiguration {
        return PickerConfiguration(entityName: "Customer",
                                   sortKey: "contactName",
                                   descriptionKey: "contactName")
    }
    
}

extension Customer: EditableItemConfiguration {
    typealias T = Customer
    
    static func editConfigurationItems() -> [ItemEditConfiguration<Customer>.Item] {
        let items: [ItemEditConfiguration<Customer>.Item] = [
            
            ItemEditConfiguration<Customer>.Item(keyPath: \Customer.address,
                                                 name: "Address"),
            ItemEditConfiguration<Customer>.Item(keyPath: \Customer.city,
                                                 name: "city"),
            ItemEditConfiguration<Customer>.Item(keyPath: \Customer.companyName,
                                                 name: "Company Name"),
            ItemEditConfiguration<Customer>.Item(keyPath: \Customer.contactName,
                                                 name: "Contact Name"),
            ItemEditConfiguration<Customer>.Item(keyPath: \Customer.contactTitle,
                                                 name: "Contact Title"),
            ItemEditConfiguration<Customer>.Item(keyPath: \Customer.country,
                                                 name: "Country"),
            ItemEditConfiguration<Customer>.Item(keyPath: \Customer.fax,
                                                 name: "Fax"),
            ItemEditConfiguration<Customer>.Item(keyPath: \Customer.phone,
                                                 name: "Phone"),
            ItemEditConfiguration<Customer>.Item(keyPath: \Customer.postalCode,
                                                 name: "Postal Code"),
            ItemEditConfiguration<Customer>.Item(keyPath: \Customer.region,
                                                 name: "Region"),
//            ItemEditConfiguration<Customer>.Item(keyPath: \Customer.demographics,
//                                                 name: "Demographics",
//                                                 writeKeyPath: "demographics",
//                                                 customClass: nil),
//            ItemEditConfiguration<Customer>.Item(keyPath: \Customer.orders,
//                                                 name: "Orders",
//                                                 writeKeyPath: "orders",
//                                                 customClass: nil)
            
        ]
        return items
    }
    
}

