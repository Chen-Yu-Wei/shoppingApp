//
//  ProductDetailViewModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/7.
//

import UIKit
import RxSwift

class ProductDetailViewModel {
    let disposeBag = DisposeBag()
    let addCartSuccessObservable = PublishSubject<Bool>()
    
    init() {}
    
    func addCartItem(obj: ProductObj) {
        let num = obj.selectedCount ?? 0
        let cartItem = CartObj(imageURL: obj.id, name: obj.name, price: String(obj.price), quantity: String(num), subTotal: String(obj.price * num))
        var oldList = CartManager.shared.shoppingList
        if let index = oldList.firstIndex(where: { $0.name == cartItem.name }) {
            guard var quantity = Int(oldList[index].quantity) else { return }
            quantity += num
            oldList[index].quantity = String(quantity)
            let price = obj.price * quantity
            oldList[index].subTotal = String(price)
        } else {
            oldList.append(cartItem)
        }
        CartManager.shared.shoppingList = oldList
        UserDefaults.standard.setValue(oldList.count, forKey: "cartCount")
        // 發送已加入購物車通知
        let notificationName = Notification.Name("addCartNotification")
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: nil)
        addCartSuccessObservable.onNext(true)
    }
}

