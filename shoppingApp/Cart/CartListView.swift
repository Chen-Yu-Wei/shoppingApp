//
//  CartListView.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/10/17.
//

import UIKit
import SnapKit

extension CartViewController {
    func addUI() {
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
            make.leading.trailing.equalToSuperview()
        }
        
        bottomView.addSubview(totalPrice)
        totalPrice.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        bottomView.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in            make.width.equalToSuperview().multipliedBy(0.3)
            make.top.equalTo(5)
            make.right.bottom.equalTo(-5)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        view.addSubview(noticeTxt)
        noticeTxt.snp.makeConstraints { make in
            make.top.equalTo(30)
            make.leading.trailing.equalToSuperview()
        }
    }
}
