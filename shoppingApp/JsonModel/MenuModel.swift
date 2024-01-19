//
//  MenuModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/4.
//

import Foundation

struct MenuListObj: Codable {
    let list: [MenuDetailObj]
}

struct MenuDetailObj: Codable {
    let title: String
    let ID: String
    let image: String
}
