//
//  NWObject+CoreDataProperties.swift
//  Northwind
//
//  Created by Michał Śmiałko on 16/01/2018.
//
//

import Foundation
import CoreData


extension NWObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NWObject> {
        return NSFetchRequest<NWObject>(entityName: "NWObject")
    }

    @NSManaged public var uniqueId: Int64

}
