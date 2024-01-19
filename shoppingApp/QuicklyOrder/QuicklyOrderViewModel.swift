//
//  QuicklyOrderViewModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/11.
//

import UIKit
import RxSwift

class QuicklyOrderViewModel {
    let disposeBag = DisposeBag()
    let productListObservable = BehaviorSubject<[ProductObj]>(value: [])
    let addCartCountObservable = PublishSubject<String>()
    let addCartSuccessObservable = PublishSubject<Bool>()
    
    var productList: [ProductObj] = []
    var addCartList: [CartObj] = []
    var topViewController: TopViewController?
    
    init() {
        fetchData()
    }
    
    /// 抓取商品資訊
    func fetchData() {
        
        ProductManager.shared.productObsevable
            .subscribe(onNext: { data in
                self.productListObservable.onNext(data)
                self.productList = data
            }).disposed(by: disposeBag)
    }
    
    /// 設定加入購物車數量
    func setAddCartCount(item: ProductObj) {
        let num = item.selectedCount ?? 0
        if let index = self.addCartList.firstIndex(where: { $0.name == item.name}) {
            if num == 0 { // 刪除商品
                self.addCartList.remove(at: index)
            } else { // 更改商品數量及個別商品總價
                self.addCartList[index].quantity = String(num)
                self.addCartList[index].subTotal = String(item.price * num)
            }
        } else { // 新增商品
            let cartItem = CartObj(imageURL: item.id, name: item.name, price: String(item.price), quantity: String(num), subTotal: String(item.price * num))
            self.addCartList.append(cartItem)
        }
        
        if self.addCartList.count > 0 {
            self.addCartCountObservable.onNext("加入購物車(\(self.addCartList.count))")
        } else {
            self.addCartCountObservable.onNext("加入購物車")
        }
    }
    
    /// 加入購物車
    func addCartItem() {
        var oldList = CartManager.shared.shoppingList
        for item in addCartList {
            if let index = oldList.firstIndex(where: { $0.name == item.name }) {
                guard var quantity = Int(oldList[index].quantity) else { return }
                quantity += Int(item.quantity)!
                oldList[index].quantity = String(quantity)
                let price = Int(item.price)! * quantity
                oldList[index].subTotal = String(price)
            } else {
                oldList.append(item)
            }
        }
        CartManager.shared.shoppingList = oldList
        UserDefaults.standard.setValue(oldList.count, forKey: "cartCount")
        // 發送已加入購物車通知
        let notificationName = Notification.Name("addCartNotification")
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: nil)
        addCartSuccessObservable.onNext(true)
        removeCartCount()
    }
    
    /// 移除加入購物車數量
    func removeCartCount() {
        self.addCartList.removeAll()
        self.addCartCountObservable.onNext("加入購物車")
        _ = self.productList.map({
            $0.selectedCount = 0
        })
    }
}
