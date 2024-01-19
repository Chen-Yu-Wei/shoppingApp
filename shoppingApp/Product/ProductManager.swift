//
//  ProductManager.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/11/9.
//

import UIKit
import RxSwift

struct ProductManager {
    static var shared = ProductManager(productList: [ProductObj]())
    var productList: [ProductObj]
    let productObsevable = ReplaySubject<[ProductObj]>.create(bufferSize: 1)
    
}
