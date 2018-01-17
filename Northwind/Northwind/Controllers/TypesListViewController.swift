//
//  TypesListViewController.swift
//  Northwind
//
//  Created by Michał Śmiałko on 16/01/2018.
//

import UIKit

class TypesListViewController: UITableViewController {

    let configurations: [ListConfiguration] = [
        Product.listConfiguration(),
        Employee.listConfiguration(),
        Category.listConfiguration(),
        Customer.listConfiguration(),
        Order.listConfiguration(),
        
        OrderDetails.listConfiguration(),
        Region.listConfiguration(),
        Shipper.listConfiguration(),
        Supplier.listConfiguration(),
        Territory.listConfiguration(),
        CustomerDemographic.listConfiguration(),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        let conf: ListConfiguration = configurations[indexPath.item]
        cell.textLabel?.text = conf.entityName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conf: ListConfiguration = configurations[indexPath.item]
        showListWith(configuration: conf)
    }
    
    func showListWith(configuration: ListConfiguration) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let listVC = storyboard.instantiateViewController(withIdentifier: "kObjectsListVCKey") as! ObjectsListViewController
        listVC.configuration = configuration
        navigationController?.pushViewController(listVC, animated: true)
    }
    
    @IBAction func didTapImport(_ sender: UIBarButtonItem) {
        let context = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
        let importer = Importer(context: context)
        importer.importData()
    }
}
