//
//  Product+CoreDataProperties.swift
//  Northwind
//
//  Created by Maciej Łobodziński on 13/12/2017.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var discontinued: Bool
    @NSManaged public var productName: String?
    @NSManaged public var quantityPerUnit: Int16
    @NSManaged public var reorderLevel: Int16
    @NSManaged public var unitPrice: NSDecimalNumber?
    @NSManaged public var unitsInStock: Int16
    @NSManaged public var unitsOnOrder: Int16
    @NSManaged public var category: Category?
    @NSManaged public var supplier: Supplier?
    @NSManaged public var details: NSSet?

}
