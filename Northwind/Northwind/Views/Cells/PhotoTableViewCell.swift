//
//  PhotoTableViewCell.swift
//  Northwind
//
//  Created by Michał Śmiałko on 18/01/2018.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var didSelect: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        didSelect = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            didSelect?()
        }
    }
    
}
