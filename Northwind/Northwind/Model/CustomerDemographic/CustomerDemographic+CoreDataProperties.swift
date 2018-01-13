//
//  CustomerDemographic+CoreDataProperties.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData


extension CustomerDemographic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CustomerDemographic> {
        return NSFetchRequest<CustomerDemographic>(entityName: "CustomerDemographic")
    }

    @NSManaged public var customers: NSSet?

}

// MARK: Generated accessors for customers
extension CustomerDemographic {

    @objc(addCustomersObject:)
    @NSManaged public func addToCustomers(_ value: Customer)

    @objc(removeCustomersObject:)
    @NSManaged public func removeFromCustomers(_ value: Customer)

    @objc(addCustomers:)
    @NSManaged public func addToCustomers(_ values: NSSet)

    @objc(removeCustomers:)
    @NSManaged public func removeFromCustomers(_ values: NSSet)

}
