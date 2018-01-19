//
//  OrderDetails+CoreDataClass.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData

@objc(OrderDetails)
public class OrderDetails: NWObject {

}

extension OrderDetails {
    static func listConfiguration() -> ListConfiguration {
        return ListConfiguration(entityName: "OrderDetails",
                                 sortKey: "discount",
                                 titleKey: "discount",
                                 priceKey: "quantity")
    }
    
}

extension OrderDetails: PickerModelDescription {
    
    static func pickerConfiguration() -> PickerConfiguration {
        return PickerConfiguration(entityName: "OrderDetails",
                                   sortKey: "discount",
                                   descriptionKey: "discount")
    }
    
}

extension OrderDetails: EditableItemConfiguration {
    typealias T = OrderDetails
    
    static func editConfigurationItems() -> [ItemEditConfiguration<OrderDetails>.Item] {
        let items: [ItemEditConfiguration<OrderDetails>.Item] = [
            
            ItemEditConfiguration<OrderDetails>.Item(keyPath: \OrderDetails.discount,
                                                     name: "Discount"),
            ItemEditConfiguration<OrderDetails>.Item(keyPath: \OrderDetails.quantity,
                                                     name: "Quantity"),
            ItemEditConfiguration<OrderDetails>.Item(keyPath: \OrderDetails.unitPrice,
                                                     name: "Unit Price"),
            ItemEditConfiguration<OrderDetails>.Item(keyPath: \OrderDetails.order,
                                                     name: "Order",
                                                     writeKeyPath: "order",
                                                     customClass: Order.classForCoder())
        ]
        return items
    }
    
}
