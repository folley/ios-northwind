//
//  Importer.swift
//  Northwind
//
//  Created by Michał Śmiałko on 16/01/2018.
//

import UIKit
import CoreData

class Importer: NSObject {

    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        super.init()
    }
    
    func importData() {
        let names: [String] = [
        "products",
        "regions",
        "categories",
        "territories",
        "employees",
        "order-details",
        "customers",
        "orders",
        "suppliers",
        "shippers"]
        
        for idx in names.indices {
            let name = names[idx]
            let path = Bundle.main.path(forResource: name, ofType: "csv")!
            let url = URL(fileURLWithPath: path)
            let fileData = try! Data(contentsOf: url)
            let fileText = String(bytes: fileData, encoding: .utf8)!
            
            switch idx {
            case 0: importProducts(fileText: fileText)
            case 1: importRegions(fileText: fileText)
            case 2: importCategories(fileText: fileText)
            case 3: importTerritories(fileText: fileText)
            case 4: importEmployees(fileText: fileText)
            case 5: importOrderDetails(fileText: fileText)
            case 6: importCustomers(fileText: fileText)
            case 7: importOrders(fileText: fileText)
            case 8: importSuppliers(fileText: fileText)
            case 9: importShippers(fileText: fileText)
            default: break
            }
        }
        
    }
    
    func importShippers(fileText: String) {
        let lines = fileText.split(separator: "\n")
        for idx in lines.indices {
            let line = lines[idx]
            if idx == 0 { continue }
            
            let components = line.split(separator: ",")
            let id = Int64(components[0])!
            
            let companyName = String(components[1])
            let phone = String(components[2])
            
            let shipper = existingOrNewObject(entityName: "Shipper", id: id) as! Shipper
            shipper.companyName = companyName
            //shipper.phone = phone
        }
    }
    
    func importSuppliers(fileText: String) {
        let lines = fileText.split(separator: "\n")
        for idx in lines.indices {
            let line = lines[idx]
            if idx == 0 { continue }
            
            let components = line.split(separator: ",")
            let id = Int64(components[0])!
            
            let companyName = String(components[1])
            let contactName = String(components[2])
            let contactTitle = String(components[3])
            let address = String(components[4])
            let city = String(components[5])
            let region = String(components[6])
            let postalCode = String(components[7])
            let country = String(components[8])
            let phone = String(components[9])
            let fax = String(components[10])
            let homePage = String(components[11])
            
            let supplier = existingOrNewObject(entityName: "Supplier", id: id) as! Supplier
            supplier.address = address
            supplier.city = city
            supplier.companyName = companyName
            supplier.contactName = contactName
            supplier.contactTitle = contactTitle
            supplier.country = country
            //supplier.fax: Int16
            supplier.homePage = homePage
            //supplier.phone: Int16
            supplier.postalCode = postalCode
            supplier.region = region
            //supplier.products: NSSet?
        }
    }
    
    func importOrders(fileText: String) {
        let lines = fileText.split(separator: "\n")
        for idx in lines.indices {
            let line = lines[idx]
            if idx == 0 { continue }
            
            let components = line.split(separator: ",")
            let id = Int64(components[0])!
            
            let customerId = String(components[1])
            let employeeId = Int64(components[2])!
            let orderDate = String(components[3])
            let requiredDate = String(components[4])
            let shippedDate = String(components[5])
            let shipViaId = Int64(components[6])!
            let freight = String(components[7])
            let shipName = String(components[8])
            let shipAddress = String(components[9])
            let shipCity = String(components[10])
            let shipRegion = String(components[11])
            let shipPostalCode = String(components[12])
            let shipCountry = String(components[13])
            
            let order = existingOrNewObject(entityName: "Order", id: id) as! Order
            order.freight = freight
            //order.orderDate = orderDate
            //order.requiredDate: NSDate?
            order.shipAddress = shipAddress
            order.shipCity = shipCity
            order.shipCountry = shipCountry
            order.shipName = shipName
            //order.shippedDate: NSDate?
            order.shipPostalCode = shipPostalCode
            order.shipRegion = shipRegion
            // TODO: order.customer = Customer?
            order.employee = existingOrNewObject(entityName: "Employee", id: employeeId) as? Employee
            //order.orderDetails: NSSet?
            order.shipVia = existingOrNewObject(entityName: "Shipper", id: shipViaId) as? Shipper
        }
        
    }
    
    func importCustomers(fileText: String) {
        let lines = fileText.split(separator: "\n")
        for idx in lines.indices {
            let line = lines[idx]
            if idx == 0 { continue }
            
            let components = line.split(separator: ",")
            let id = Int64(components[0])!
            
            let companyName = String(components[1])
            let contactName = String(components[2])
            let contactTitle = String(components[3])
            let address = String(components[4])
            let city = String(components[5])
            let region = String(components[6])
            let postalCode = String(components[7])
            let country = String(components[8])
            let phone = String(components[9])
            let fax = String(components[10])
            
            let customer = existingOrNewObject(entityName: "Customer", id: id) as! Customer
            customer.address = address
            customer.city = city
            customer.companyName = companyName
            customer.contactName = contactName
            customer.contactTitle = contactTitle
            customer.country = country
            //customer.fax = fax
            //customer.phone = phone
            customer.postalCode = postalCode
            customer.region = region
            //customer.demographics = ...
            //customer.orders = ...
        }
    }
    
    func importOrderDetails(fileText: String) {
        let lines = fileText.split(separator: "\n")
        for idx in lines.indices {
            let line = lines[idx]
            if idx == 0 { continue }
            
            let components = line.split(separator: ",")
            let id = Int64(components[0])!
            let productId = Int64(components[1])!
            let unitPrice = NSDecimalNumber(string: String(components[2]))
            let quantity = Int16(components[3])!
            let discount = NSDecimalNumber(string: String(components[4]))
         
            let orderDetails = existingOrNewObject(entityName: "OrderDetails", id: id) as! OrderDetails
            orderDetails.unitPrice = unitPrice
            orderDetails.quantity = quantity
            orderDetails.discount = discount
        }
    }
    
    func importEmployees(fileText: String) {
        let lines = fileText.split(separator: "\n")
        for idx in lines.indices {
            let line = lines[idx]
            if idx == 0 { continue }
            
            let components = line.split(separator: ",")
            
            let id = Int64(components[0])!
            let lastName = String(components[1])
            let firstName = String(components[2])
            let title = String(components[3])
            let titleOfCourtesy = String(components[4])
            let birthDate = components[5]
            let hireDate = components[6]
            let address = String(components[7])
            let city = String(components[8])
            let region = String(components[9])
            let postalCode = String(components[10])
            let country = String(components[11])
            let homePhone = components[12]
            let phoneExt = components[13]
            let photo = components[14]
            let notes = String(components[15])
            let reportsTo = Int64(components[16])!
            let photoPath = components[17]
            
            
            let employee = existingOrNewObject(entityName: "Employee", id: id) as! Employee
            employee.address = address
            //employee.birthDate: NSDate?
            employee.city = city
            employee.country = country
            //employee.employeeExtension: String?
            employee.firstName = firstName
            //employee.hireDate: NSDate?
            //employee.homePhone: Int16
            employee.lastName = lastName
            employee.notes = notes
            //employee.photo: NSData?
            //employee.photoPath: String?
            employee.postalCode = postalCode
            employee.region = region
            employee.title = title
            employee.titleOfCourtesy = titleOfCourtesy
            //employee.managedEmployees: NSSet?
            //employee.orders: NSSet?
            employee.reportsTo = existingOrNewObject(entityName: "Employee", id: reportsTo) as? Employee
            //employee.territories: NSSet?
        }
    }
    
    func importTerritories(fileText: String) {
        let lines = fileText.split(separator: "\n")
        for idx in lines.indices {
            let line = lines[idx]
            if idx == 0 { continue }
            
            let components = line.split(separator: ",")
            
            let id = Int64(components[0])!
            let desc = String(components[1])
            let regionId = Int64(components[2])!
            let territory = existingOrNewObject(entityName: "Territory", id: id) as! Territory
            territory.territoryDescription = desc
            territory.region = existingOrNewObject(entityName: "Region", id: regionId) as? Region
        }
    }
    
    func importCategories(fileText: String) {
        let lines = fileText.split(separator: "\n")
        for idx in lines.indices {
            let line = lines[idx]
            if idx == 0 { continue }
            
            let components = line.split(separator: ",")
            
            let id = Int64(components[0])!
            let name = String(components[1])
            let desc = String(components[2])
            let category = existingOrNewObject(entityName: "Category", id: id) as! Category
            category.categoryName = name
            category.categoryDescription = desc
        }
    }
    
    func importRegions(fileText: String) {
        let lines = fileText.split(separator: "\n")
        for idx in lines.indices {
            let line = lines[idx]
            if idx == 0 { continue }
            
            let components = line.split(separator: ",")
            
            let id = Int64(components[0])!
            let desc = String(components[1])
            
            let region = existingOrNewObject(entityName: "Region", id: id) as! Region
            region.regionDescription = desc
        }
    }
    
    func importProducts(fileText: String) {
        let lines = fileText.split(separator: "\n")
        for idx in lines.indices {
            let line = lines[idx]
            if idx == 0 { continue }
            let components = line.split(separator: ",")
            
            let id = Int64(components[0])!
            let name = String(components[1])
            let supplierId = Int64(components[2])!
            let categoryId = Int64(components[3])!
            let quantityPerUnit = String(components[4])
            let unitPrice = NSDecimalNumber(string: String(components[5]))
            let unitsInStock = Int16(components[6])!
            let unitsOnOrder = Int16(components[7])!
            let reorderLevel = Int16(components[8])!
            let discontinued = Int(components[9]) == 0 ? false : true
            
            let product = existingOrNewObject(entityName: "Product", id: id) as! Product
            product.discontinued = discontinued
            product.productName = name
            //product.quantityPerUnit: Int16
            product.reorderLevel = reorderLevel
            product.unitPrice = unitPrice
            product.unitsInStock = unitsInStock
            product.unitsOnOrder = unitsOnOrder
            product.category = existingOrNewObject(entityName: "Category", id: categoryId) as? Category
            product.supplier = existingOrNewObject(entityName: "Supplier", id: supplierId) as? Supplier
        }
    }
    
    func existingOrNewObject(entityName: String, id: Int64) -> NWObject {
        let fetchRequest = NSFetchRequest<NWObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "uniqueId == %i", id)
        let results = try! context.fetch(fetchRequest)
        if let first = results.first {
            return first
        }
        else {
            let newObject = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! NWObject
            newObject.uniqueId = id
            return newObject
        }
        
    }
    
}
