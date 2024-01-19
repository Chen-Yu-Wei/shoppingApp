//
//  ProductListViewModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/7.
//

import UIKit
import RxSwift

class ProductListViewModel{
    let disposeBag = DisposeBag()
    let productListObservable = BehaviorSubject<[ProductObj]>(value: [])
    var productList: [ProductObj] = []
    
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
}
