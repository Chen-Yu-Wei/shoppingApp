//
//  CartViewListCell.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/10/17.
//

import UIKit
import RxSwift
import SnapKit

class CartViewListCell: UITableViewCell {
    lazy var productImage: UIImageView = {
        let imageview = UIImageView()
        imageview.backgroundColor = .lightGray
        return imageview
    }()
    
    lazy var productName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var productPrice: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var addBtn: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        return button
    }()
    
    lazy var countTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .center
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        return textField
    }()
    
    lazy var minusBtn: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        return button
    }()
    
    lazy var deleteBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Ｘ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var disposeBag = DisposeBag()
    var cartProductObj: CartObj? {
        didSet {
            setData(obj: cartProductObj!)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setObservable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
    
    func setData(obj: CartObj){
        productName.text = obj.name
        productPrice.text = "NT$\(obj.price)"
        countTextField.text = obj.quantity
        minusBtn.backgroundColor = Int(obj.quantity)! > 1 ? .white : .lightGray
        minusBtn.isEnabled = Int(obj.quantity)! > 1 ? true : false
        self.layoutIfNeeded()
    }
    
    func setObservable() {
        
    }
    
    func setUI() {
        self.selectionStyle = .none
        contentView.addSubview(productImage)
        contentView.addSubview(deleteBtn)
        contentView.addSubview(productName)
        contentView.addSubview(productPrice)
        contentView.addSubview(minusBtn)
        contentView.addSubview(countTextField)
        contentView.addSubview(addBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        productImage.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.height.width.equalTo(90)
            make.centerY.equalToSuperview()
        }
        
        deleteBtn.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.right.equalTo(-15)
            make.width.height.equalTo(30)
        }
        
        productName.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.left.equalTo(productImage.snp.right).offset(15)
            make.right.equalTo(deleteBtn.snp.left).offset(-8)
        }
        
        productPrice.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).offset(8)
            make.left.equalTo(productName)
            make.trailing.equalToSuperview()
        }
        
        minusBtn.snp.makeConstraints { make in
            make.top.equalTo(productPrice.snp.bottom).offset(15)
            make.left.equalTo(productName)
//            make.right.equalTo(countTextField.snp.left)
            make.height.equalTo(25)
            make.width.equalToSuperview().multipliedBy(0.08)
            make.bottom.equalTo(-15)
        }
        
        countTextField.snp.makeConstraints { make in
            make.left.equalTo(minusBtn.snp.right)
            make.height.equalTo(25)
            make.width.equalToSuperview().multipliedBy(0.13)
            make.centerY.equalTo(minusBtn)
        }
        
        addBtn.snp.makeConstraints { make in
            make.left.equalTo(countTextField.snp.right)
            make.height.equalTo(25)
            make.width.equalToSuperview().multipliedBy(0.08)
            make.centerY.equalTo(minusBtn)
        }
    }
}
