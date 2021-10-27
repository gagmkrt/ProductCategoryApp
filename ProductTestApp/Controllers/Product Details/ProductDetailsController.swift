//
//  ProductDetailsController.swift
//  ProductTestApp
//
//  Created by Gago Mkrtchyan on 26.10.21.
//

import UIKit

struct ProdDetails {
    var name: String?
    var id: Int?
    var date: String?
}

class ProductDetailsController: UIViewController {
    
    @IBOutlet weak var prodImage: UIImageView!
    @IBOutlet weak var prodName: UILabel!
    @IBOutlet weak var prodId: UILabel!
    @IBOutlet weak var prodDate: UILabel!
    
    var prodData = ProdDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI(name: prodData.name ?? "", id: prodData.id ?? 0, date: prodData.date ?? "")
    }
    
    private func setupUI(name: String, id: Int, date: String) {
        prodImage.image = UIImage(named: "apple_juice")
        prodName.text = name
        prodId.text = String(id)
        prodDate.text = date
    }
}
