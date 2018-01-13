//
//  Order+CoreDataProperties.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var freight: String?
    @NSManaged public var orderDate: NSDate?
    @NSManaged public var requiredDate: NSDate?
    @NSManaged public var shipAddress: String?
    @NSManaged public var shipCity: String?
    @NSManaged public var shipCountry: String?
    @NSManaged public var shipName: String?
    @NSManaged public var shippedDate: NSDate?
    @NSManaged public var shipPostalCode: String?
    @NSManaged public var shipRegion: String?
    @NSManaged public var customer: Customer?
    @NSManaged public var employee: Employee?
    @NSManaged public var orderDetails: NSSet?
    @NSManaged public var shipVia: Shipper?

}

// MARK: Generated accessors for orderDetails
extension Order {

    @objc(addOrderDetailsObject:)
    @NSManaged public func addToOrderDetails(_ value: OrderDetails)

    @objc(removeOrderDetailsObject:)
    @NSManaged public func removeFromOrderDetails(_ value: OrderDetails)

    @objc(addOrderDetails:)
    @NSManaged public func addToOrderDetails(_ values: NSSet)

    @objc(removeOrderDetails:)
    @NSManaged public func removeFromOrderDetails(_ values: NSSet)

}
