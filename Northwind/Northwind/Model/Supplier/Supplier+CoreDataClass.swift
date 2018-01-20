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
public class Supplier: NWObject {

}

extension Supplier {
    static func listConfiguration() -> ListConfiguration {
        return ListConfiguration(entityName: "Supplier",
                                 sortKey: "companyName",
                                 titleKey: "companyName",
                                 priceKey: "country")
    }
    
}

extension Supplier: PickerModelDescription {
    
    static func pickerConfiguration() -> PickerConfiguration {
        return PickerConfiguration(entityName: "Supplier",
                                   sortKey: "companyName",
                                   descriptionKey: "companyName")
    }
    
}

extension Supplier: EditableItemConfiguration {
    typealias T = Supplier
    
    static func editConfigurationItems() -> [ItemEditConfiguration<Supplier>.Item] {
        let items: [ItemEditConfiguration<Supplier>.Item] = [
            
            ItemEditConfiguration<Supplier>.Item(keyPath: \Supplier.address,
                                                 name: "Address"),
            ItemEditConfiguration<Supplier>.Item(keyPath: \Supplier.city,
                                                 name: "City"),
            ItemEditConfiguration<Supplier>.Item(keyPath: \Supplier.companyName,
                                                 name: "Company Name"),
            ItemEditConfiguration<Supplier>.Item(keyPath: \Supplier.contactName,
                                                 name: "Contact Name"),
            ItemEditConfiguration<Supplier>.Item(keyPath: \Supplier.contactTitle,
                                                 name: "Contact Title"),
            ItemEditConfiguration<Supplier>.Item(keyPath: \Supplier.country,
                                                 name: "Country"),
            ItemEditConfiguration<Supplier>.Item(keyPath: \Supplier.fax,
                                                 name: "Fax"),
            ItemEditConfiguration<Supplier>.Item(keyPath: \Supplier.homePage,
                                                 name: "Home Page"),
            ItemEditConfiguration<Supplier>.Item(keyPath: \Supplier.phone,
                                                 name: "Phone"),
            ItemEditConfiguration<Supplier>.Item(keyPath: \Supplier.postalCode,
                                                 name: "Postal Code"),
            ItemEditConfiguration<Supplier>.Item(keyPath: \Supplier.region,
                                                 name: "Region"),
//            ItemEditConfiguration<Supplier>.Item(keyPath: \Supplier.products,
//                                                 name: "Products",
//                                                 writeKeyPath: "products",
//                                                 customClass: nil)
            
        ]
        return items
    }
    
}
