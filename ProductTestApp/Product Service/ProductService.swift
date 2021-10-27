//
//  ProductService.swift
//  ProductTestApp
//
//  Created by Gago Mkrtchyan on 26.10.21.
//

import Foundation

class ProductService {
    
    static let shared = ProductService()
    
    func getProdCategoryData(completion: @escaping ([ProdCategoryItems]?, Error?) -> Void) {
        let paramsDict = [String: Any]()
        let header = ["Accept":"application/json"]
        
        let url = "http://62.109.7.98/api/categories"
        
        NetworkService.shared.getRequest(params: paramsDict, headers: header, urlString: url) { result, error in
            
            if error != nil {
                
                completion(nil, error)
            } else if let result = result {
                let data = ProdCategoryModel(serverDict: result)
                let prod = data.data
                
                completion(prod, nil)
            }
        }
    }
    
    func getProductsData(category: String, completion: @escaping ([ProductItems]?, Error?) -> Void) {
        let paramsDict = [String: Any]()
        let header = ["Accept":"application/json"]
        
        let url = "http://62.109.7.98/api/product/category/" + category
        
        NetworkService.shared.getRequest(params: paramsDict, headers: header, urlString: url) { result, error in
            
            if error != nil {
                
                completion(nil, error)
            } else if let result = result {
                let data = ProductModel(serverDict: result)
                let prod = data.data
                
                completion(prod, nil)
            }
        }
    }
}
