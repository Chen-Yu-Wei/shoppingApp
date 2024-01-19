//
//  MemberServiceViewModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/8/17.
//

import UIKit
import RxSwift

class MemberServiceViewModel {
    let disposeBag = DisposeBag()
    let memberMenuListObservable = BehaviorSubject<[MemberMenuObj]>(value: [])
    var memberMenuList: [MemberMenuObj] = []
    
    init(){
        fetchData()
    }
    
    func fetchData(){
        let urlStr = "https://raw.githubusercontent.com/Chen-Yu-Wei/JSON_API/main/memberMenu.json"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                let decoder = JSONDecoder()
                if let data = data, let response = response as? HTTPURLResponse {
                    print("Status Code: \(response.statusCode)")
                    do {
                        let decodedData = try decoder.decode(MemberMenuListObj.self, from: data)
                        self.memberMenuList = decodedData.list
                        self.memberMenuListObservable.onNext(self.memberMenuList)
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
