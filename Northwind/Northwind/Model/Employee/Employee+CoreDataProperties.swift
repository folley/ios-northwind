//
//  Employee+CoreDataProperties.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var address: String?
    @NSManaged public var birthDate: NSDate?
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var employeeExtension: String?
    @NSManaged public var firstName: String?
    @NSManaged public var hireDate: NSDate?
    @NSManaged public var homePhone: Int16
    @NSManaged public var lastName: String?
    @NSManaged public var notes: String?
    @NSManaged public var photo: NSData?
    @NSManaged public var photoPath: String?
    @NSManaged public var postalCode: String?
    @NSManaged public var region: String?
    @NSManaged public var title: String?
    @NSManaged public var titleOfCourtesy: String?
    @NSManaged public var managedEmployees: NSSet?
    @NSManaged public var orders: NSSet?
    @NSManaged public var reportsTo: Employee?
    @NSManaged public var territories: NSSet?

}

// MARK: Generated accessors for managedEmployees
extension Employee {

    @objc(addManagedEmployeesObject:)
    @NSManaged public func addToManagedEmployees(_ value: Employee)

    @objc(removeManagedEmployeesObject:)
    @NSManaged public func removeFromManagedEmployees(_ value: Employee)

    @objc(addManagedEmployees:)
    @NSManaged public func addToManagedEmployees(_ values: NSSet)

    @objc(removeManagedEmployees:)
    @NSManaged public func removeFromManagedEmployees(_ values: NSSet)

}

// MARK: Generated accessors for orders
extension Employee {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: Order)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: Order)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}

// MARK: Generated accessors for territories
extension Employee {

    @objc(addTerritoriesObject:)
    @NSManaged public func addToTerritories(_ value: Territory)

    @objc(removeTerritoriesObject:)
    @NSManaged public func removeFromTerritories(_ value: Territory)

    @objc(addTerritories:)
    @NSManaged public func addToTerritories(_ values: NSSet)

    @objc(removeTerritories:)
    @NSManaged public func removeFromTerritories(_ values: NSSet)

}
