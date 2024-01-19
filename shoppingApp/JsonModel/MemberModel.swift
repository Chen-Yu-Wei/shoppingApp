//
//  MemberModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/8/17.
//

import Foundation

struct MemberMenuListObj: Codable {
    let list: [MemberMenuObj]
}

struct MemberMenuObj: Codable {
    let title: String
    let ID: String
    let image: String
}
