//
//  ProductCellViewController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/8/21.
//

import UIKit
import RxSwift
import SnapKit

class ProductCellViewController: UICollectionViewCell {
    var productObj: ProductObj = ProductObj(id: "", name: "", price: 0, description: "", category: "", availability: true){
        didSet{
            setData(obj: productObj)
        }
    }
    
    lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.image = UIImage(named: "prepare")
        return image
    }()
    
    lazy var productName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    lazy var productPrice: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var favBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        return super.preferredLayoutAttributesFitting(layoutAttributes)
//    }
    
    func setData(obj: ProductObj) {
        self.productName.text = obj.name
        self.productPrice.text = "NT$" + String(obj.price)
    }
    
    func setUI() {
        
        // 邊框
        contentView.layer.cornerRadius = 5.0
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.clear.cgColor

        // 一定要設背景顏色！要不然會所有物件都有陰影
        layer.backgroundColor = UIColor.white.cgColor
        // 陰影
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)//CGSizeMake(0, 2.0);
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        
        contentView.addSubview(productImage)
        contentView.addSubview(productName)
        contentView.addSubview(productPrice)
        contentView.addSubview(favBtn)
        
        productImage.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.centerX.equalToSuperview()
//            make.right.equalTo(-10)
            make.height.equalTo(120).priority(999)
//            make.width.equalTo((screenWidth - 75) / 2)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        productName.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(10)
            make.leading.trailing.equalTo(productImage)
        }
        
        favBtn.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.width.height.equalTo(30)
            make.centerY.equalTo(productPrice)
        }
        
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).offset(8)
            make.leading.equalTo(productName)
            make.right.equalTo(favBtn.snp.left).offset(-10)
            make.height.equalTo(30)
            make.bottom.equalTo(-10)
        }
    }
}
