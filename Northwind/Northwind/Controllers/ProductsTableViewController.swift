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
    
    var model = [("Baklazan", Double(123.12)), ("Frytki", Double(21.31))]

    @IBAction func addButtonTapped(_ sender: Any) {
        
        let managedContext = self.fetchedResultsController.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: managedContext)
        let product = Product(entity: entity!, insertInto: managedContext)
        product.productName = "Kabanos"
        product.unitPrice = NSDecimalNumber(value: arc4random_uniform(123))
        
        do {
            try managedContext.save()
        }
        catch let error as NSError {
            print("\(error)")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(UINib.init(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
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
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        
        let product = self.fetchedResultsController.object(at: indexPath)
        
        let config = ProductDetailsVC.Configuration.init(product:product)
        
        vc.item = config
        
        self.navigationController?.pushViewController(vc, animated: true)
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
