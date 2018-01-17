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
public class Product: NWObject {

}

extension Product {
    
    static func listConfiguration() -> ListConfiguration {
        return ListConfiguration(entityName: "Product",
                                 sortKey: "productName",
                                 titleKey: "productName")
    }
    
}

extension Product: PickerModelDescription {
    
    static func pickerConfiguration() -> PickerConfiguration {
        return PickerConfiguration(entityName: "Product",
                                   sortKey: "productName",
                                   descriptionKey: "productName")
    }
    
}

extension Product: EditableItemConfiguration {
    typealias T = Product
    
    static func editConfigurationItems() -> [ItemEditConfiguration<Product>.Item] {
        let items = [ItemEditConfiguration<Product>.Item(keyPath: \Product.productName,
                                                         name: "Product Name"),
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.discontinued,
                                                         name: "Discontinued"),
                     
                     
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.quantityPerUnit,
                                                         name: "Quantity Per Unit"),
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.reorderLevel,
                                                         name: "Reorder Level"),
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.unitPrice,
                                                         name: "Unit Price"),
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.unitsInStock,
                                                         name: "Units In Stock"),
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.unitsOnOrder,
                                                         name: "Units On Order"),
                     
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.category,
                                                         name: "Category",
                                                         writeKeyPath: "category",
                                                         customClass: Category.classForCoder()),
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.supplier,
                                                         name: "Supplier",
                                                         writeKeyPath: "supplier",
                                                         customClass: Supplier.classForCoder())
        ]
        return items
    }
    
}
