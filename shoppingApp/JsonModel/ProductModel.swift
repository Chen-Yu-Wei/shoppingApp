//
//  ProductModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/18.
//

import Foundation

class ProductListObj: Codable {
    let products: [ProductObj]
}

class ProductObj: Codable {
    let id: String
    let name: String
    let price: Int
    let description: String
    let category: String
    let availability: Bool
    let limited_time_offer: Bool
    var selectedCount: Int? = 0
    
    init(id: String, name: String, price: Int, description: String, category: String, availability: Bool, limited_time_offer: Bool = false, selectedCount: Int? = 0) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.category = category
        self.availability = availability
        self.limited_time_offer = limited_time_offer
        self.selectedCount = selectedCount
    }
}
