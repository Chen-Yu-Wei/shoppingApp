//
//  MemberServiceView.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/8/17.
//

import UIKit
import RxSwift
import SnapKit

extension MemberServiceViewController {
    func setUI() {
        self.view.addSubview(memberCardView)
        memberCardView.snp.makeConstraints { make in
            make.top.left.equalTo(15)
            make.right.equalTo(-15)
//            make.height.equalTo(300)
        }
        
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(memberCardView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(memberCardView)
            make.height.equalTo(100)
        }
        
    }
}
