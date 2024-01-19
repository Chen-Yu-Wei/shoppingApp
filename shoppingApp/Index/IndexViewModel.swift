//
//  IndexViewModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/7.
//

import UIKit
import RxSwift

class IndexViewModel {
    let productListObservable = BehaviorSubject<[ProductObj]>(value: [])
    var newsListObservable = BehaviorSubject<[NewsDetailObj]>(value: [])
    let disposeBag = DisposeBag()
    var saleProductList: [ProductObj] = []
    var newsList: [NewsDetailObj] = []
    var subNewsList: [NewsDetailObj] = [] //用於顯示在首頁，只顯示前五筆最新消息
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        // 取商品api
        let apiUrl = "https://raw.githubusercontent.com/Chen-Yu-Wei/JSON_API/main/product_list.json"
        
        if let url = URL(string: apiUrl) {
            URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data, let response = response as? HTTPURLResponse {
                    print("status Code: \(response.statusCode)")
                    do {
                        let decodedData = try decoder.decode(ProductListObj.self, from: data)
                        self.saleProductList = decodedData.products.filter({ $0.limited_time_offer })
                        self.productListObservable.onNext(self.saleProductList)
                        ProductManager.shared.productList = decodedData.products
                        ProductManager.shared.productObsevable.onNext(decodedData.products)
                    } catch {
                        print("error")
                    }
                }
            }.resume()
        }
        
        // 取最新消息api
        let urlStr = "https://raw.githubusercontent.com/Chen-Yu-Wei/JSON_API/main/news_list.json"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data, let response = response as? HTTPURLResponse {
                    print("Status Code:\(response.statusCode)")
                    do {
                        let newsResponse = try decoder.decode(NewsListObj.self, from: data)
                        self.newsList = newsResponse.announcements
                        self.subNewsList = Array(self.newsList.prefix(5))
                        self.newsListObservable.onNext(self.subNewsList)
                    } catch {
                        print("error")
                    }
                } else {
                    print("error")
                }
            }.resume()
        }
    }
}
