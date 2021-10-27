//
//  ProductsViewController.swift
//  ProductTestApp
//
//  Created by Gago Mkrtchyan on 26.10.21.
//

import UIKit

class ProductsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel = ProductsViewModel()
    
    public var category = ""
    
    private var prodArray = [ProductItems]() {
        didSet {
            UIView.performWithoutAnimation {
                tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .none)
            }
        }
    }
    
    private let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        viewModel.getProducts(category: category)
        filterField()
    }
    
    @objc func refresh(sender: UIRefreshControl) {
        viewModel.getProducts(category: category)
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        searchBar.delegate = self
        tableView.refreshControl = myRefreshControl
        
        tableView.register(UINib(nibName: ProductsTableViewCell.identi, bundle: nil), forCellReuseIdentifier: ProductsTableViewCell.identi)
    }
    
    private func filterField(text: String? = nil) {
        
        guard let text = text, text.count != 0 else {
            self.prodArray = viewModel.prodData
            return
        }
    
        self.prodArray = viewModel.prodData.filter { $0.name?.lowercased().contains(text.lowercased()) ?? false}
    }
    
    private func product(at index: IndexPath) -> ProductItems? {
        
        if index.row < prodArray.count {
            
            let token: ProductItems = prodArray[index.row]
            return token
        }
        return nil
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return prodArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.identi, for: indexPath) as! ProductsTableViewCell
        
        if let data = product(at: indexPath) {
            cell.setData(data: data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailsController") as! ProductDetailsController
        
        vc.prodData.name = prodArray[indexPath.row].name
        vc.prodData.id = prodArray[indexPath.row].id
        vc.prodData.date = prodArray[indexPath.row].date
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            prodArray.remove(at: indexPath.row)
            tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .none)
        }
    }
}

extension ProductsViewController: ProductsViewModelDelegate {
    func getProducstData(data: [ProductItems]) {
        
        viewModel.prodData = data
        filterField()
        tableView.reloadData()
        myRefreshControl.endRefreshing()
    }
}

extension ProductsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filterField(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
