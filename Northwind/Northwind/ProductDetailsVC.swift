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
        let productName : String
        let productPrice : Double
    }
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = item?.productName
        priceTextField.text = String(describing: (item?.productPrice)!)
    }
    
    func configure(with item: Configuration?) {
        self.title = item?.productName
    }
}
