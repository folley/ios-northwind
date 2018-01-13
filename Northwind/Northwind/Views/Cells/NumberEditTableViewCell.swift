//
//  NumberEditTableViewCell.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//

import UIKit

class NumberEditTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    var didChange: ((NSNumber?) -> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        didChange = nil
    }
    
    @IBAction func didChangeText(_ sender: UITextField) {
        guard let text = sender.text else {
            didChange?(nil)
            return
        }
        
        let formatter = NumberFormatter()
        let number = formatter.number(from: text)
        didChange?(number)
    }
    
}
