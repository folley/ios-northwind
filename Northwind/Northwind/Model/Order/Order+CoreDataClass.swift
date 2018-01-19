//
//  Order+CoreDataClass.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData

@objc(Order)
public class Order: NWObject {

}

extension Order {
    
    static func listConfiguration() -> ListConfiguration {
        return ListConfiguration(entityName: "Order",
                                 sortKey: "orderDate",
                                 titleKey: "shipAddress",
                                 priceKey: "orderDate")
    }
    
}

extension Order: PickerModelDescription {
    
    static func pickerConfiguration() -> PickerConfiguration {
        return PickerConfiguration(entityName: "Order",
                                   sortKey: "orderDate",
                                   descriptionKey: "shipAddress")
    }
    
}

extension Order: EditableItemConfiguration {
    typealias T = Order
    
    static func editConfigurationItems() -> [ItemEditConfiguration<Order>.Item] {
        let items: [ItemEditConfiguration<Order>.Item] = [
            
            ItemEditConfiguration<Order>.Item(keyPath: \Order.freight,
                                              name: "Freight"),
            ItemEditConfiguration<Order>.Item(keyPath: \Order.orderDate,
                                              name: "Order Date"),
            ItemEditConfiguration<Order>.Item(keyPath: \Order.requiredDate,
                                              name: "Required Date"),
            ItemEditConfiguration<Order>.Item(keyPath: \Order.shipAddress,
                                              name: "Ship Address"),
            ItemEditConfiguration<Order>.Item(keyPath: \Order.shipCity,
                                              name: "Ship City"),
            ItemEditConfiguration<Order>.Item(keyPath: \Order.shipCountry,
                                              name: "Ship Country"),
            ItemEditConfiguration<Order>.Item(keyPath: \Order.shipName,
                                              name: "Ship Name"),
            ItemEditConfiguration<Order>.Item(keyPath: \Order.shippedDate,
                                              name: "Shipped Date"),
            ItemEditConfiguration<Order>.Item(keyPath: \Order.shipPostalCode,
                                              name: "Ship Postal Code"),
            ItemEditConfiguration<Order>.Item(keyPath: \Order.shipRegion,
                                              name: "Ship Region"),
            ItemEditConfiguration<Order>.Item(keyPath: \Order.customer,
                                              name: "Customer",
                                              writeKeyPath: "customer",
                                              customClass: Customer.classForCoder()),
            ItemEditConfiguration<Order>.Item(keyPath: \Order.employee,
                                              name: "Employee",
                                              writeKeyPath: "emplotee",
                                              customClass: Employee.classForCoder()),
//            ItemEditConfiguration<Order>.Item(keyPath: \Order.orderDetails,
//                                              name: "Order Details",
//                                              writeKeyPath: "orderDetails",
//                                              customClass: nil),
            ItemEditConfiguration<Order>.Item(keyPath: \Order.shipVia,
                                              name: "Ship Via",
                                              writeKeyPath: "shipVia",
                                              customClass: Shipper.classForCoder())
        ]
        return items
    }
    
}

