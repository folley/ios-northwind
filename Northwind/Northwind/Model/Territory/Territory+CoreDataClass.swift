//
//  Territory+CoreDataClass.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData

@objc(Territory)
public class Territory: NWObject {

}

extension Territory {
    static func listConfiguration() -> ListConfiguration {
        return ListConfiguration(entityName: "Territory",
                                 sortKey: "territoryDescription",
                                 titleKey: "territoryDescription",
                                 priceKey: "territoryDescription")
    }
    
}

extension Territory: PickerModelDescription {
    
    static func pickerConfiguration() -> PickerConfiguration {
        return PickerConfiguration(entityName: "Territory",
                                   sortKey: "territoryDescription",
                                   descriptionKey: "territoryDescription")
    }
    
}

extension Territory: EditableItemConfiguration {
    typealias T = Territory
    
    static func editConfigurationItems() -> [ItemEditConfiguration<Territory>.Item] {
        let items: [ItemEditConfiguration<Territory>.Item] = [
            
            ItemEditConfiguration<Territory>.Item(keyPath: \Territory.territoryDescription,
                                                  name: "Description"),
//            ItemEditConfiguration<Territory>.Item(keyPath: \Territory.employees,
//                                                  name: "Employees",
//                                                  writeKeyPath: "employees",
//                                                  customClass: nil)
            ItemEditConfiguration<Territory>.Item(keyPath: \Territory.region,
                                                  name: "Region",
                                                  writeKeyPath: "region",
                                                  customClass: Region.classForCoder())
            
        ]
        return items
    }
    
}

