//
//  BoolEditTableViewCell.swift
//  Northwind
//
//  Created by Sebastian Korzeniak
//

import UIKit

class BoolEditTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueSwitch: UISwitch!
    var didChange: ((Bool) -> Void)?
    
    @IBAction func didChangeValue(_ sender: UISwitch) {
        didChange?(sender.isOn)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        didChange = nil
    }
    
}
