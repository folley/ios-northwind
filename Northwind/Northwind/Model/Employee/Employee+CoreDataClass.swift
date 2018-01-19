//
//  Employee+CoreDataClass.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//
//

import Foundation
import CoreData

@objc(Employee)
public class Employee: NWObject {

}

extension Employee {
    static func listConfiguration() -> ListConfiguration {
        return ListConfiguration(entityName: "Employee",
                                 sortKey: "lastName",
                                 titleKey: "lastName",
                                 priceKey: "lastName")
    }
    
}

extension Employee: PickerModelDescription {
    
    static func pickerConfiguration() -> PickerConfiguration {
        return PickerConfiguration(entityName: "Employee",
                                   sortKey: "lastName",
                                   descriptionKey: "lastName")
    }
    
}

extension Employee: EditableItemConfiguration {
    typealias T = Employee
    
    static func editConfigurationItems() -> [ItemEditConfiguration<Employee>.Item] {
        let items: [ItemEditConfiguration<Employee>.Item] = [
            
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.address,
                                                 name: "Address"),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.birthDate,
                                                 name: "Birth Date"),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.city,
                                                 name: "City"),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.country,
                                                 name: "country"),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.employeeExtension,
                                                 name: "Extension"),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.firstName,
                                                 name: "First Name"),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.hireDate,
                                                 name: "Hire Date"),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.homePhone,
                                                 name: "Home Phone"),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.lastName,
                                                 name: "Last Name"),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.notes,
                                                 name: "Notes"),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.photo,
                                                 name: "Photo",
                                                 writeKeyPath: "photo",
                                                 customClass: NSData.classForCoder()),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.photoPath,
                                                 name: "Photo Path"),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.postalCode,
                                                 name: "Postal Code"),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.region,
                                                 name: "Region"),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.title,
                                                 name: "Title"),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.titleOfCourtesy,
                                                 name: "Title of Courtesy"),
//            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.managedEmployees,
//                                                 name: "Managed Employees",
//                                                 writeKeyPath: "managedEmployees",
//                                                 customClass: nil),
//            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.orders,
//                                                 name: "Orders",
//                                                 writeKeyPath: "orders",
//                                                 customClass: nil),
            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.reportsTo,
                                                 name: "Reports To",
                                                 writeKeyPath: "reportsTo",
                                                 customClass: Employee.classForCoder()),
//            ItemEditConfiguration<Employee>.Item(keyPath: \Employee.territories,
//                                                 name: "Territories",
//                                                 writeKeyPath: "territories",
//                                                 customClass: nil)
            
            
        ]
        return items
    }
    
}
