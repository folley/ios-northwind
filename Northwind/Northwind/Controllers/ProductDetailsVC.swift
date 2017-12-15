//
//  ProductViewController.swift
//  Northwind
//
//  Created by Maciej Łobodziński on 12/12/2017.
//

import UIKit

class ProductDetailsVC: UIViewController {

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
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        if let product = item?.product {
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
        
        nameTextField.text = item?.product.productName
        priceTextField.text = String(describing: (item?.product.unitPrice)!)
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
}
