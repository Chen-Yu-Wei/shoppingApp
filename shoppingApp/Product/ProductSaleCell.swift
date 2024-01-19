//
//  ProductSaleCell.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/11/9.
//

import UIKit

class ProductSaleCell: UICollectionViewCell {
    
    lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .gray
        image.image = UIImage(named: "prepare")
        return image
    }()
    
    lazy var productName: UILabel = {
        let label = UILabel()
//        label.numberOfLines = 0
        return label
    }()
    
    /// 打折前的價錢
    lazy var productPrice: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    /// 打折後的價錢
    lazy var productSalePrice: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    var productObj: ProductObj = ProductObj(id: "", name: "", price: 0, description: "", category: "", availability: true){
        didSet {
            setData(obj: productObj)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(obj: ProductObj) {
        
        self.productName.text = obj.name
        
        let salePrice = Int(Double(obj.price) * 0.8)
        let price = "$" + String(obj.price)
        
        self.productSalePrice.text = "8折$" + String(salePrice)
        
        let attributedString = NSMutableAttributedString(string: price)
        attributedString.addAttribute(.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
        self.productPrice.attributedText = attributedString
    }
    
    func setUI() {
        contentView.backgroundColor = .white
        // 邊框
        contentView.layer.cornerRadius = 5.0
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.clear.cgColor
        
        contentView.addSubview(productImage)
        contentView.addSubview(productName)
        contentView.addSubview(productSalePrice)
        contentView.addSubview(productPrice)
        
        productImage.snp.makeConstraints { make in
            make.top.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(120)
            make.width.equalTo(screenWidth / 2 - 60).priority(999)
        }
        
        productName.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(10)
            make.leading.trailing.equalTo(productImage)
        }
        
        productSalePrice.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).offset(12)
            make.leading.trailing.equalTo(productName)
        }
        
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(productSalePrice.snp.bottom).offset(5)
            make.leading.trailing.equalTo(productName)
            make.bottom.equalTo(-10)
        }
    }
}
