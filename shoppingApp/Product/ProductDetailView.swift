//
//  ProductDetailView.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/7.
//

import UIKit
import SnapKit

extension ProductDetailViewController {
    func setUI(){
        self.view.addSubview(imageView)
        self.view.addSubview(shareBtn)
        self.view.addSubview(productName)
        self.view.addSubview(productPrice)
//        self.view.addSubview(productDescTitle)
        self.view.addSubview(productDesc)
        self.view.addSubview(minusBtn)
        self.view.addSubview(countTextField)
        self.view.addSubview(addBtn)
        self.view.addSubview(addCartBtn)
        
        imageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(0.7)
        }
        
        productName.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
        }
        
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).offset(10)
            make.leading.trailing.equalTo(productName)
        }
        
        productDesc.snp.makeConstraints { make in
            make.top.equalTo(productPrice.snp.bottom).offset(10)
            make.leading.trailing.equalTo(productPrice)
        }
        
        minusBtn.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.12)
        }
        
        countTextField.snp.makeConstraints { make in
            make.left.equalTo(minusBtn.snp.right)
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        
        addBtn.snp.makeConstraints { make in
            make.left.equalTo(countTextField.snp.right)
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview().multipliedBy(0.12)
        }
        
        addCartBtn.snp.makeConstraints { make in
//            make.top.equalTo(productDesc.snp.bottom).offset(10)
            make.left.equalTo(addBtn.snp.right)
            make.trailing.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
    }
}
