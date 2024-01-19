//
//  CartViewModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/10/17.
//

import UIKit
import RxSwift

class CartViewModel {
    let cartListObservable = BehaviorSubject<[CartObj]>(value: [])
    
    init() {
//        fetchData()
    }
    
    func fetchData() {
        let cartList = CartManager.shared.shoppingList
        cartListObservable.onNext(cartList)
    }
}
