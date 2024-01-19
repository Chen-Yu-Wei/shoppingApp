//
//  cartModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/9/26.
//

import Foundation

struct CartObj: Codable, Equatable {
    let imageURL: String
    let name: String
    let price: String
    var quantity: String
    var subTotal: String
}
