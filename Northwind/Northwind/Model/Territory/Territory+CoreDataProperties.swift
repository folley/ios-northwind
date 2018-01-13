//
//  Territory+CoreDataProperties.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData


extension Territory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Territory> {
        return NSFetchRequest<Territory>(entityName: "Territory")
    }

    @NSManaged public var territoryDescription: String?
    @NSManaged public var employees: NSSet?
    @NSManaged public var region: Region?

}

// MARK: Generated accessors for employees
extension Territory {

    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: Employee)

    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: Employee)

    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: NSSet)

    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: NSSet)

}
