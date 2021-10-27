//
//  ProductCategoryCell.swift
//  ProductTestApp
//
//  Created by Gago Mkrtchyan on 26.10.21.
//

import UIKit

class ProductCategoryCell: UITableViewCell {
    
    static let identi = "ProductCategoryCell"
    
    @IBOutlet weak var categoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setData(data: ProdCategoryItems) {
        categoryName.text = data.name
    }
}
