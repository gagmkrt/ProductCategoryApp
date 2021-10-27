//
//  ProductsViewModel.swift
//  ProductTestApp
//
//  Created by Gago Mkrtchyan on 26.10.21.
//

import Foundation

protocol ProductsViewModelDelegate: AnyObject {
    func getProducstData(data: [ProductItems])
}

class ProductsViewModel {
    
    var prodData = [ProductItems]()
    
    weak var delegate: ProductsViewModelDelegate?
    
    func getProducts(category: String) {
        ProductService.shared.getProductsData(category: category) { products, error in
            
            if error != nil {
                
            } else if let prod = products {
                self.delegate?.getProducstData(data: prod)
            }
        }
    }
    
    func products(at index: IndexPath) -> ProductItems? {
        
        if (index.row < prodData.count) {
            
            let prod: ProductItems = prodData[index.row]
            return prod
        }
        
        return nil
    }
}
