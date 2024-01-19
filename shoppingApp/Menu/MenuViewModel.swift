//
//  MenuViewModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/4.
//

import UIKit
import RxSwift

class MenuViewModel {
    let disposeBag = DisposeBag()
    var menuListObservable = BehaviorSubject<[MenuDetailObj]>(value: [])
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        let urlStr = "https://raw.githubusercontent.com/Chen-Yu-Wei/JSON_API/main/menu.json"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data, let response = response as? HTTPURLResponse {
                    print("status code: \(response.statusCode)")
                    do {
                        let decodeData = try decoder.decode(MenuListObj.self, from: data)
                        self.menuListObservable.onNext(decodeData.list)
                    } catch {
                        print("error: \(error)")
                    }
                }
            }.resume()
        }
    }
}
