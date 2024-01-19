//
//  NewsDetailView.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/6/16.
//

import UIKit
import SnapKit

extension NewsDetailViewController {
    func setUI() {
        view.addSubview(headLine)
        view.addSubview(date)
        view.addSubview(content)
        
        headLine.snp.makeConstraints { make in
            make.top.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        date.snp.makeConstraints { make in
            make.top.equalTo(headLine.snp.bottom).offset(10)
            make.leading.trailing.equalTo(headLine)
        }
        
        content.snp.makeConstraints { make in
            make.top.equalTo(date.snp.bottom).offset(10)
            make.leading.trailing.equalTo(headLine)
            make.bottom.equalTo(-20)
        }
    }
}
