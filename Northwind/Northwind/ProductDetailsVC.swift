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
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productNameLabel.text = item?.productName
        productPriceLabel.text = String(describing: (item?.productPrice)!)
    }
    
    func configure(with item: Configuration?) {
        self.title = item?.productName
    }
}
