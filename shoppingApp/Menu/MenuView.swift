//
//  MenuView.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/4.
//

import Foundation

extension MenuViewController {
   
    func setUI() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalToSuperview()
            make.right.equalTo(-90)
        }
        
        view.addSubview(logoutBtn)
        logoutBtn.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-100)
            make.bottom.equalTo(-10)
            make.height.equalTo(40)
        }
    }
}
