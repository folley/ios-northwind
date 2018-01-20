//
//  OrderDetails+CoreDataProperties.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData


extension OrderDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrderDetails> {
        return NSFetchRequest<OrderDetails>(entityName: "OrderDetails")
    }

    @NSManaged public var discount: NSDecimalNumber?
    @NSManaged public var quantity: Int16
    @NSManaged public var unitPrice: NSDecimalNumber?
    @NSManaged public var order: Order?
    @NSManaged public var product: Product?

}
