//
//  ProductsTableViewController.swift
//  Northwind
//
//  Created by Maciej Łobodziński on 12/12/2017.
//

import UIKit
import CoreData

class ProductsTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var _fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> {
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let sort = NSSortDescriptor(key: "productName", ascending: true)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.sortDescriptors = [sort];
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        self._fetchedResultsController = aFetchedResultsController
        
        do {
            try self._fetchedResultsController!.performFetch()
        }
        catch let error as NSError {
            print("\(error.localizedDescription)")
        }
        
        return self._fetchedResultsController!
    }
    
    var model = [("Baklazan", Double(123.12)), ("Frytki", Double(21.31))]

    @IBAction func addButtonTapped(_ sender: Any) {
        
        let managedContext = self.fetchedResultsController.managedObjectContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Product", in: managedContext)
        let product = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        product.setValue("Kabanos", forKey: "productName")
        product.setValue(Double(arc4random_uniform(123)), forKey: "unitPrice")
        
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
    
        self.tableView.register(UINib.init(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return info.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let product = self.fetchedResultsController.object(at: indexPath) as! Product
        
        cell.productNameLabel.text = product.productName
        cell.priceLabel.text = String(describing: (product.unitPrice)!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
        
        let product = self.fetchedResultsController.object(at: indexPath) as! Product
        
        let config = ProductDetailsVC.Configuration.init(product:product)
        
        vc.item = config
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: NSFetchedRequestControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
    func controller(controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChangeObject object: AnyObject,
                    atIndexPath indexPath: NSIndexPath?,
                    forChangeType type: NSFetchedResultsChangeType,
                    newIndexPath: NSIndexPath?) {
    }
}
