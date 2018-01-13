//
//  ProductViewController.swift
//  Northwind
//
//  Created by Maciej Łobodziński on 12/12/2017.
//

import UIKit
import CoreData

class ProductDetailsVC: UITableViewController {

    var item : Configuration? {
        didSet {
            self.configure(with: item)
        }
    }
    
    public struct Configuration {
        let product : Product
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var supplierNameLabel: UILabel!
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        if let product = item?.product {
            product.managedObjectContext?.delete(product)
            product.managedObjectContext?.northwindSave()
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshUI()
    }
    
    fileprivate func refreshUI() {
        let product = item!.product
        nameTextField.text = product.productName
        priceTextField.text = String(describing: (product.unitPrice)!)
        categoryNameLabel.text = product.category?.categoryName
        supplierNameLabel.text = product.supplier?.companyName
        tableView.reloadData()
    }
    
    @IBAction func nameDidChange(_ sender: UITextField) {
        item?.product.productName = sender.text
        save()
    }
    
    @IBAction func priceDidChange(_ sender: UITextField) {
        if let text = sender.text {
            if let value = Double(text) {
                item?.product.unitPrice = NSDecimalNumber(value: value)
                save()
            }
        }
    }
    
    private func save() {
        item?.product.managedObjectContext?.northwindSave()
    }
    
    func configure(with item: Configuration?) {
        self.title = item?.product.productName
    }
    
    @IBAction func didTapCategory(_ sender: UITapGestureRecognizer) {
        showPicker(configuration: Category.pickerConfiguration())
    }
    
    @IBAction func didTapSupplier(_ sender: UITapGestureRecognizer) {
        showPicker(configuration: Supplier.pickerConfiguration())
    }
    
    private func showPicker(configuration: PickerConfiguration) {
        let vc = UIStoryboard.pickerVC()
        vc.configuration = configuration
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductDetailsVC: ObjectPickerDelegate {
    func objectPicker(_ picker: ObjectPickerViewController, didPick item: NSManagedObject) {
        navigationController?.popToViewController(self, animated: true)
        
        if let category = item as? Category {
            self.item?.product.category = category
        }
        else if let supplier = item as? Supplier {
            self.item?.product.supplier = supplier
        }
        
        refreshUI()
    }
}
