//
//  ProductsTableViewCell.swift
//  ProductTestApp
//
//  Created by Gago Mkrtchyan on 26.10.21.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    
    static let identi = "ProductsTableViewCell"
    
    @IBOutlet weak var prodName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func setData(data: ProductItems) {
        prodName.text = data.name
    }
}
