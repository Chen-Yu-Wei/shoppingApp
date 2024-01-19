//
//  CartManager.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/9/26.
//

import Foundation

struct CartManager{
    static var shared = CartManager(shoppingList: [CartObj]())
    var shoppingList: [CartObj]
    
    /// 修改商品數量
    mutating func updateQuantityAndSubTotal(cartItem: CartObj, quantity: String, subTotal: String) -> [CartObj]{
        if let itemIndex = shoppingList.firstIndex(of: cartItem) {
            shoppingList[itemIndex].quantity = quantity
            shoppingList[itemIndex].subTotal = subTotal
        }
        return shoppingList
    }
    
    /// 刪除商品
    mutating func remove(cartItem: CartObj) -> [CartObj] {
        if let itemIndex = shoppingList.firstIndex(of: cartItem) {
            shoppingList.remove(at: itemIndex)
        }
        return shoppingList
    }
    
    /// 取得總價
    func getTotal() -> String {
        var total = 0
        for item in shoppingList {
            if let quantity = Int(item.quantity), let price = Int(item.price) {
                total += quantity * price
            }
        }
        return String(total)
    }
    
    /// 清空購物車
    mutating func cleanCart() {
        shoppingList.removeAll()
    }
}
