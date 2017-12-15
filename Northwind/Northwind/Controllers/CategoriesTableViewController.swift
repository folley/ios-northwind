//
//  CategoriesTableViewController.swift
//  Northwind
//
//  Created by Maciej Łobodziński on 15/12/2017.
//

import UIKit
import CoreData

class CategoriesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    lazy var fetchedResultsController: NSFetchedResultsController<Category> = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let sort = NSSortDescriptor(key: "categoryName", ascending: true)
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
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
        
        let entity = NSEntityDescription.entity(forEntityName: "Category", in: managedContext)
        let category = Category(entity: entity!, insertInto: managedContext)
        category.categoryName = "Category Name"
        category.categoryDescription = "Desc"
        managedContext.northwindSave()
        
        showDetailsFor(category: category)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib.init(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
    }
    
    private func showDetailsFor(category: Category) {
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return info.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let category = self.fetchedResultsController.object(at: indexPath)
        
        cell.productNameLabel.text = category.categoryName
        cell.priceLabel.text = category.categoryDescription
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = self.fetchedResultsController.object(at: indexPath)
        showDetailsFor(category: category)
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

extension CategoriesTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "categoryName CONTAINS[cd] %@", searchText)
        } else {
            fetchedResultsController.fetchRequest.predicate = nil
        }
        try! fetchedResultsController.performFetch()
        tableView.reloadData()
    }
    
    func CategoriesTableViewController(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
