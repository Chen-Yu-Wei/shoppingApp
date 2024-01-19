//
//  ProductListView.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/7.
//

import UIKit

extension ProductListViewController {
    func setUI() {
        view.addSubview(productCollectionView)
//        productCollectionView?.translatesAutoresizingMaskIntoConstraints = false
//        productCollectionView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
//        productCollectionView?.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
//        productCollectionView?.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
//        productCollectionView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

        productCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
