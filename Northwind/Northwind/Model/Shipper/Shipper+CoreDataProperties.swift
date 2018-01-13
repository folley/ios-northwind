//
//  Shipper+CoreDataProperties.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData


extension Shipper {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shipper> {
        return NSFetchRequest<Shipper>(entityName: "Shipper")
    }

    @NSManaged public var companyName: String?
    @NSManaged public var phone: Int16
    @NSManaged public var orders: NSSet?

}

// MARK: Generated accessors for orders
extension Shipper {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: Order)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: Order)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}
