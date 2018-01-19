//
//  Region+CoreDataClass.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData

@objc(Region)
public class Region: NWObject {

}

extension Region {
    static func listConfiguration() -> ListConfiguration {
        return ListConfiguration(entityName: "Region",
                                 sortKey: "regionDescription",
                                 titleKey: "regionDescription",
                                 priceKey: "regionDescription")
    }
    
}

extension Region: PickerModelDescription {
    
    static func pickerConfiguration() -> PickerConfiguration {
        return PickerConfiguration(entityName: "Region",
                                   sortKey: "regionDescription",
                                   descriptionKey: "regionDescription")
    }
    
}

extension Region: EditableItemConfiguration {
    typealias T = Region
    
    static func editConfigurationItems() -> [ItemEditConfiguration<Region>.Item] {
        let items: [ItemEditConfiguration<Region>.Item] = [
            
            ItemEditConfiguration<Region>.Item(keyPath: \Region.regionDescription,
                                               name: "Description"),
//            ItemEditConfiguration<Region>.Item(keyPath: \Region.territories,
//                                               name: "Territories",
//                                               writeKeyPath: "territories",
//                                               customClass: nil)
        ]
        return items
    }
    
}
