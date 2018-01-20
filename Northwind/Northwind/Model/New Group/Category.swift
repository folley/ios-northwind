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

extension Category {
    static func listConfiguration() -> ListConfiguration {
        return ListConfiguration(entityName: "Category",
                                 sortKey: "categoryName",
                                 titleKey: "categoryName",
                                 priceKey: "categoryDescription")
    }
    
}

extension Category: PickerModelDescription {
    
    static func pickerConfiguration() -> PickerConfiguration {
        return PickerConfiguration(entityName: "Category",
                                   sortKey: "categoryName",
                                   descriptionKey: "categoryName")
    }
    
}

extension Category: EditableItemConfiguration {
    typealias T = Category
    
    static func editConfigurationItems() -> [ItemEditConfiguration<Category>.Item] {
        let items: [ItemEditConfiguration<Category>.Item] = [
            
            ItemEditConfiguration<Category>.Item(keyPath: \Category.categoryDescription,
                                                 name: "Description"),
            ItemEditConfiguration<Category>.Item(keyPath: \Category.categoryName,
                                                 name: "Name"),
            ItemEditConfiguration<Category>.Item(keyPath: \Category.picture,
                                                 name: "Picture"),
//            ItemEditConfiguration<Category>.Item(keyPath: \Category.products,
//                                                 name: "Products",
//                                                 writeKeyPath: "products",
//                                                 customClass: nil)
            
            
        ]
        return items
    }
    
}
