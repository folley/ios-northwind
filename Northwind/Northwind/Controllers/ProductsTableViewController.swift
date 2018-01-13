//
//  ProductsTableViewController.swift
//  Northwind
//
//  Created by Maciej Łobodziński on 12/12/2017.
//

import UIKit
import CoreData

class ProductsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    lazy var fetchedResultsController: NSFetchedResultsController<Product> = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let sort = NSSortDescriptor(key: "productName", ascending: true)
        let fetchRequest = NSFetchRequest<Product>(entityName: "Product")
        fetchRequest.sortDescriptors = [sort];
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                   managedObjectContext: managedContext,
                                                                   sectionNameKeyPath: nil,
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
        
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: managedContext)
        let product = Product(entity: entity!, insertInto: managedContext)
        product.productName = "Product Name"
        product.unitPrice = NSDecimalNumber(value: 0)
        managedContext.northwindSave()
        
        showDetailsFor(product: product)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(UINib.init(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
    }
    
    private func showDetailsFor(product: Product) {
        let items = [ItemEditConfiguration<Product>.Item(keyPath: \Product.productName,
                                                         name: "Product Name"),
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.discontinued,
                                                         name: "Discontinued"),
                     
                     
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.quantityPerUnit,
                                                         name: "Quantity Per Unit"),
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.reorderLevel,
                                                         name: "Reorder Level"),
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.unitPrice,
                                                         name: "Unit Price"),
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.unitsInStock,
                                                         name: "Units In Stock"),
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.unitsOnOrder,
                                                         name: "Units On Order"),
                     
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.category,
                                                         name: "Category",
                                                         writeKeyPath: "category",
                                                         customClass: Category.classForCoder()),
                     ItemEditConfiguration<Product>.Item(keyPath: \Product.supplier,
                                                         name: "Supplier",
                                                         writeKeyPath: "supplier",
                                                         customClass: Supplier.classForCoder())
            ]
        let configuration = ItemEditConfiguration(object: product,
                                                  items: items)
        let editVC = ItemEditViewController<Product>(style: .grouped)
        editVC.configuration = configuration
        self.navigationController?.pushViewController(editVC, animated: true)
        return
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        let config = ProductDetailsVC.Configuration.init(product:product)
        vc.item = config
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return info.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let product = self.fetchedResultsController.object(at: indexPath)
        
        cell.productNameLabel.text = product.productName
        cell.priceLabel.text = String(describing: (product.unitPrice)!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.fetchedResultsController.object(at: indexPath)
        showDetailsFor(product: product)
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
}

extension ProductsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "productName CONTAINS[cd] %@", searchText)
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
