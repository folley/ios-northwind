//
//  Region+CoreDataProperties.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData


extension Region {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Region> {
        return NSFetchRequest<Region>(entityName: "Region")
    }

    @NSManaged public var regionDescription: String?
    @NSManaged public var territories: NSSet?

}

// MARK: Generated accessors for territories
extension Region {

    @objc(addTerritoriesObject:)
    @NSManaged public func addToTerritories(_ value: Territory)

    @objc(removeTerritoriesObject:)
    @NSManaged public func removeFromTerritories(_ value: Territory)

    @objc(addTerritories:)
    @NSManaged public func addToTerritories(_ values: NSSet)

    @objc(removeTerritories:)
    @NSManaged public func removeFromTerritories(_ values: NSSet)

}
