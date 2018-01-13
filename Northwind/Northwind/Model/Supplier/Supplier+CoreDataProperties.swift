//
//  Supplier+CoreDataProperties.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData


extension Supplier {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Supplier> {
        return NSFetchRequest<Supplier>(entityName: "Supplier")
    }

    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var companyName: String?
    @NSManaged public var contactName: String?
    @NSManaged public var contactTitle: String?
    @NSManaged public var country: String?
    @NSManaged public var fax: Int16
    @NSManaged public var homePage: String?
    @NSManaged public var phone: Int16
    @NSManaged public var postalCode: String?
    @NSManaged public var region: String?
    @NSManaged public var products: NSSet?

}

// MARK: Generated accessors for products
extension Supplier {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}
