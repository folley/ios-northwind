//
//  ObjectPickerViewController.swift
//  Northwind
//
//  Created by Michał Śmiałko on 15/12/2017.
//

import UIKit
import CoreData

protocol ObjectPickerDelegate: class {
    func objectPicker(_ picker: ObjectPickerViewController,
                      didPickItem: NSManagedObject)
}

class ObjectPickerViewController: UITableViewController {

    weak var delegate: ObjectPickerDelegate?
    var entityName: String!
    var sortKey: String!
    
    lazy var fetchedResultsController: NSFetchedResultsController<NSManagedObject> = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let sort = NSSortDescriptor(key: sortKey, ascending: true)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }


}

extension ObjectPickerViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.fetchedObjects!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let item = fetchedResultsController.fetchedObjects![indexPath.item]
        
        cell.textLabel?.text = indexPath.description
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = fetchedResultsController.fetchedObjects![indexPath.item]
        delegate?.objectPicker(self,
                               didPickItem: item)
    }
}

extension ObjectPickerViewController: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
}
