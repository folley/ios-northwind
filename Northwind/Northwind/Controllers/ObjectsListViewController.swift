//
//  ProductsTableViewController.swift
//  Northwind
//
//  Created by Maciej Łobodziński on 12/12/2017.
//

import UIKit
import CoreData

struct ListConfiguration {
    let entityName: String
    let sortKey: String
    
    // for cells
    let titleKey: String
    let priceKey: String
}

class ObjectsListViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var configuration: ListConfiguration!
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let sort = NSSortDescriptor(key: configuration.sortKey, ascending: true)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: configuration.entityName)
        fetchRequest.sortDescriptors = [sort];
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                   managedObjectContext: managedContext,
                                                                   sectionNameKeyPath: nil,//configuration.sortKey,
                                                                   cacheName: nil)
        aFetchedResultsController.delegate = self
        
        do {
            try aFetchedResultsController.performFetch()
        }
        catch let error as NSError {
            print("\(error.localizedDescription)")
        }
        
        return aFetchedResultsController
    }()
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let managedContext = self.fetchedResultsController.managedObjectContext
        let object = NSEntityDescription.insertNewObject(forEntityName: configuration.entityName, into: managedContext)
        managedContext.northwindSave()
        showDetailsFor(object: object)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = configuration.entityName
        tableView.register(UINib.init(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
    }
    
    private func showDetailsFor(object: NSManagedObject) {
        var toShowVC: UIViewController?
        
        
        //
        // I know, I know....
        // This is bad....
        // But time/quality pressure here....
        // 
        if let product = object as? Product {
            let items = Product.editConfigurationItems()
            let configuration = ItemEditConfiguration(object: product,
                                                      items: items)
            let editVC = ItemEditViewController<Product>(style: .grouped)
            editVC.configuration = configuration
            toShowVC = editVC
        }
        else if let order = object as? Order {
            let items = Order.editConfigurationItems()
            let configuration = ItemEditConfiguration(object: order,
                                                      items: items)
            let editVC = ItemEditViewController<Order>(style: .grouped)
            editVC.configuration = configuration
            toShowVC = editVC
        }
        else if let orderDetails = object as? OrderDetails {
            let items = OrderDetails.editConfigurationItems()
            let configuration = ItemEditConfiguration(object: orderDetails,
                                                      items: items)
            let editVC = ItemEditViewController<OrderDetails>(style: .grouped)
            editVC.configuration = configuration
            toShowVC = editVC
        }
        else if let region = object as? Region {
            let items = Region.editConfigurationItems()
            let configuration = ItemEditConfiguration(object: region,
                                                      items: items)
            let editVC = ItemEditViewController<Region>(style: .grouped)
            editVC.configuration = configuration
            toShowVC = editVC
        }
        else if let shipper = object as? Shipper {
            let items = Shipper.editConfigurationItems()
            let configuration = ItemEditConfiguration(object: shipper,
                                                      items: items)
            let editVC = ItemEditViewController<Shipper>(style: .grouped)
            editVC.configuration = configuration
            toShowVC = editVC
        }
        else if let supplier = object as? Supplier {
            let items = Supplier.editConfigurationItems()
            let configuration = ItemEditConfiguration(object: supplier,
                                                      items: items)
            let editVC = ItemEditViewController<Supplier>(style: .grouped)
            editVC.configuration = configuration
            toShowVC = editVC
        }
        else if let territory = object as? Territory {
            let items = Territory.editConfigurationItems()
            let configuration = ItemEditConfiguration(object: territory,
                                                      items: items)
            let editVC = ItemEditViewController<Territory>(style: .grouped)
            editVC.configuration = configuration
            toShowVC = editVC
        }
        else if let customer = object as? Customer {
            let items = Customer.editConfigurationItems()
            let configuration = ItemEditConfiguration(object: customer,
                                                      items: items)
            let editVC = ItemEditViewController<Customer>(style: .grouped)
            editVC.configuration = configuration
            toShowVC = editVC
        }
        else if let demographics = object as? CustomerDemographic {
            let items = CustomerDemographic.editConfigurationItems()
            let configuration = ItemEditConfiguration(object: demographics,
                                                      items: items)
            let editVC = ItemEditViewController<CustomerDemographic>(style: .grouped)
            editVC.configuration = configuration
            toShowVC = editVC
        }
        else if let employee = object as? Employee {
            let items = Employee.editConfigurationItems()
            let configuration = ItemEditConfiguration(object: employee,
                                                      items: items)
            let editVC = ItemEditViewController<Employee>(style: .grouped)
            editVC.configuration = configuration
            toShowVC = editVC
        }
        else if let category = object as? Category {
            let items = Category.editConfigurationItems()
            let configuration = ItemEditConfiguration(object: category,
                                                      items: items)
            let editVC = ItemEditViewController<Category>(style: .grouped)
            editVC.configuration = configuration
            toShowVC = editVC
        }
        
        navigationController?.pushViewController(toShowVC!, animated: true)
//
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
//        let config = ProductDetailsVC.Configuration.init(product:product)
//        vc.item = config
//        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return info.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let object = self.fetchedResultsController.object(at: indexPath) as! NSManagedObject
        var name = object.value(forKey: configuration.titleKey) as? String
        
        if let number = object.value(forKey: configuration.titleKey) as? NSDecimalNumber {
            name = number.stringValue
        }
        
        let desc = object.value(forKey: configuration.priceKey) as? String
        
        cell.nameLabel.text = name
        
        if name != desc {
            cell.descLabel.text = desc
        }
        else {
            cell.descLabel.text = ""
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = self.fetchedResultsController.object(at: indexPath) as! NSManagedObject
        showDetailsFor(object: object)
    }
    
    // MARK: NSFetchedRequestControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    //tableindex
}

extension ObjectsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "\(configuration.titleKey) CONTAINS[cd] %@", searchText)
        } else {
            fetchedResultsController.fetchRequest.predicate = nil
        }
        try! fetchedResultsController.performFetch()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}
