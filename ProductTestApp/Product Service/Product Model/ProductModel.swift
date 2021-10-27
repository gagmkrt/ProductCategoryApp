//
//  ProductModel.swift
//  ProductTestApp
//
//  Created by Gago Mkrtchyan on 26.10.21.
//

import Foundation

// Product Category Models
class ProdCategoryModel {
    var data: [ProdCategoryItems]?
    
    init(serverDict: [String: Any]) {
        let dataDict = serverDict["data"] as? [[String: Any]] ?? [[String: Any]]()
        var prodData = [ProdCategoryItems]()
        
        dataDict.forEach { item in
            let data = ProdCategoryItems(serverDict: item)
            prodData.append(data)
        }
        self.data = prodData
    }
}

class ProdCategoryItems {
    var id: Int?
    var name: String?
    
    init(serverDict: [String: Any]) {
        self.id = serverDict["id"] as? Int
        self.name = serverDict["name"] as? String
    }
}

// Product Models
class ProductModel {
    var data: [ProductItems]?
    
    init(serverDict: [String: Any]) {
        let dataDict = serverDict["data"] as? [[String: Any]] ?? [[String: Any]]()
        var prodData = [ProductItems]()
        
        dataDict.forEach { item in
            let data = ProductItems(serverDict: item)
            prodData.append(data)
        }
        self.data = prodData
    }
}

class ProductItems {
    var id: Int?
    var name: String?
    var date: String?
    var created_at: String?
    
    init(serverDict: [String: Any]) {
        self.id = serverDict["id"] as? Int
        self.name = serverDict["name"] as? String
        self.date = serverDict["date"] as? String
        self.created_at = serverDict["created_at"] as? String
    }
}
