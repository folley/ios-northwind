//
//  Customer+CoreDataProperties.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var companyName: String?
    @NSManaged public var contactName: String?
    @NSManaged public var contactTitle: String?
    @NSManaged public var country: String?
    @NSManaged public var fax: Int16
    @NSManaged public var phone: Int16
    @NSManaged public var postalCode: String?
    @NSManaged public var region: String?
    @NSManaged public var demographics: NSSet?
    @NSManaged public var orders: NSSet?

}

// MARK: Generated accessors for demographics
extension Customer {

    @objc(addDemographicsObject:)
    @NSManaged public func addToDemographics(_ value: CustomerDemographic)

    @objc(removeDemographicsObject:)
    @NSManaged public func removeFromDemographics(_ value: CustomerDemographic)

    @objc(addDemographics:)
    @NSManaged public func addToDemographics(_ values: NSSet)

    @objc(removeDemographics:)
    @NSManaged public func removeFromDemographics(_ values: NSSet)

}

// MARK: Generated accessors for orders
extension Customer {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: Order)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: Order)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}
