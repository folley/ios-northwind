//
//  CategoryDetailsVC.swift
//  Northwind
//
//  Created by Maciej Łobodziński on 16/12/2017.
//

//
//  ProductViewController.swift
//  Northwind
//
//  Created by Maciej Łobodziński on 12/12/2017.
//

import UIKit
import CoreData

class CategoryDetailsVC: UITableViewController {
    
    var item : Configuration? {
        didSet {
            self.configure(with: item)
        }
    }
    
    public struct Configuration {
        let category : Category
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        if let product = item?.category {
            product.managedObjectContext?.delete(product)
            product.managedObjectContext?.northwindSave()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = item?.category.categoryName
        priceTextField.text = item?.category.categoryDescription
    }
    
    @IBAction func nameDidChange(_ sender: UITextField) {
        item?.category.categoryName = sender.text
        save()
    }
    
    @IBAction func priceDidChange(_ sender: UITextField) {
        item?.category.categoryDescription = sender.text
        save()
    }
    
    private func save() {
        item?.category.managedObjectContext?.northwindSave()
    }
    
    func configure(with item: Configuration?) {
        self.title = item?.category.categoryName
    }
}

extension CategoryDetailsVC {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

