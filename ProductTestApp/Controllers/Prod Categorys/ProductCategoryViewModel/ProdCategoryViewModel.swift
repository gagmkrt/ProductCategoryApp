//
//  ProdCategoryViewModel.swift
//  ProductTestApp
//
//  Created by Gago Mkrtchyan on 26.10.21.
//

import Foundation

protocol ProdCategoryViewModelDelegate: AnyObject {
    func getCategoryData(data: [ProdCategoryItems])
}

class ProdCategoryViewModel {
    
    var categoryModel = [ProdCategoryItems]()
    
    weak var delegate: ProdCategoryViewModelDelegate?
    
    public func getProdCategory() {
        ProductService.shared.getProdCategoryData { category, error in
            
            if error != nil {
                
            } else if let result = category {
                self.delegate?.getCategoryData(data: result)
            }
        }
    }
    
    func products(at index: IndexPath) -> ProdCategoryItems? {
        
        if (index.row < categoryModel.count) {
            
            let prod: ProdCategoryItems = categoryModel[index.row]
            return prod
        }
        
        return nil
    }
}
