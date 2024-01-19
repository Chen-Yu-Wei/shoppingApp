//
//  NewsListViewModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/6/9.
//

import UIKit
import RxSwift

class NewsListViewModel {
    let disposeBag = DisposeBag()
    var newsList: [NewsDetailObj] = []
    var newsListObservable = BehaviorSubject<[NewsDetailObj]>(value: [])
        
    init() {
        fetchData()
    }
    
    func fetchData() {
        let urlStr = "https://raw.githubusercontent.com/Chen-Yu-Wei/JSON_API/main/news_list.json"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data, let response = response as? HTTPURLResponse {
                    print("Status Code:\(response.statusCode)")
                    do {
                        let newsResponse = try decoder.decode(NewsListObj.self, from: data)
                        self.newsList = newsResponse.announcements
                        self.newsListObservable.onNext(self.newsList)
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
