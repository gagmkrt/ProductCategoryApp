//
//  ProductCategoryController.swift
//  ProductTestApp
//
//  Created by Gago Mkrtchyan on 26.10.21.
//

import UIKit

class ProductCategoryController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = ProdCategoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.getProdCategory()
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        
        tableView.register(UINib(nibName: ProductCategoryCell.identi, bundle: nil), forCellReuseIdentifier: ProductCategoryCell.identi)
    }
}

extension ProductCategoryController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.categoryModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCategoryCell.identi, for: indexPath) as! ProductCategoryCell
        
        if let data = viewModel.products(at: indexPath) {
            cell.setData(data: data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        
        let index = indexPath.row + 1
        vc.category = String(index)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductCategoryController: ProdCategoryViewModelDelegate {
    func getCategoryData(data: [ProdCategoryItems]) {
        
        viewModel.categoryModel = data
        tableView.reloadData()
    }
}
