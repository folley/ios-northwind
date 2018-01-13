//
//  TextEditTableViewCell.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//

import UIKit

class TextEditTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var didEditText: ((String?) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        didEditText = nil
    }

    @IBAction func textFieldDidChange(_ sender: UITextField) {
        didEditText?(sender.text)
    }
    
}
