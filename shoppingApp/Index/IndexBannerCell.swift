//
//  IndexBannerCell.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/11/7.
//

import UIKit
import SnapKit

class IndexBannerCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imageview = UIImageView()
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(imageView.snp.height)
        }
    }
}
