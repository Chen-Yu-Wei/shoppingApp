//
//  NewsModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/6/14.
//

import Foundation

struct NewsListObj: Codable {
    let announcements: [NewsDetailObj]
}

struct NewsDetailObj: Codable {
    let title: String
    let date: String
    let content: String
}
