//
//  NewsListView.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/6/9.
//

import UIKit
import SnapKit

extension NewsListViewController {
    func setUI() {
        view.addSubview(newsTableView)
        
        newsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
