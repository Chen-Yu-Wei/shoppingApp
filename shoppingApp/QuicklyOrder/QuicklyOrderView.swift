//
//  QuicklyOrderView.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/18.
//

import UIKit

extension QuicklyOrderViewController {
    func setUI() {
        view.addSubview(addBtn)
        addBtn.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(addBtn.snp.top)
        }
    }
}
