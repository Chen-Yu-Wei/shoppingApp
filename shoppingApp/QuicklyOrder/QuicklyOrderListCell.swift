//
//  QuicklyOrderListCell.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/10.
//

import UIKit
import RxSwift

class QuicklyOrderListCell: UITableViewCell {
    
    lazy var productName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var productPrize: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        return label
    }()
    
    lazy var addBtn: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
//        button.backgroundColor = .lightGray
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
        textField.text = "0"
        return textField
    }()
    
    lazy var minusBtn: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
//        button.backgroundColor = .lightGray
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        return button
    }()
    
//    lazy var countSelect: UITextField = {
//        let textField = UITextField()
//        textField.inputView = pickerView
//        textField.text = String(numArray.first ?? 0)
//        textField.borderStyle = .roundedRect
//        textField.textAlignment = .center
//        return textField
//    }()
    
    lazy var checkIcon: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    var viewModel: QuicklyOrderViewModel?
    let disposeBag = DisposeBag()
    let pickerView = UIPickerView()
    let numArray: [Int] = Array(0...99)
    var productObj: ProductObj? {
        didSet {
            setData(data: productObj!)
        }
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setCellUI()
        setObservable()
        
//        pickerView.delegate = self
//        pickerView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCellUI() {
        selectionStyle = .none
        contentView.addSubview(checkIcon)
//        contentView.addSubview(countSelect)
        contentView.addSubview(minusBtn)
        contentView.addSubview(countTextField)
        contentView.addSubview(addBtn)
        contentView.addSubview(productPrize)
        contentView.addSubview(productName)
    }
    
    func setData(data: ProductObj) {
        self.productName.text = data.name
        self.productPrize.text = "NT$\(data.price)"
        self.countTextField.text = "\(data.selectedCount ?? 0)"
        if data.selectedCount ?? 0 == 0 {
            self.checkIcon.isSelected = false
            self.backgroundColor = .white
        } else {
            self.checkIcon.isSelected = true
            self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        self.layoutIfNeeded()
    }
    
    func setObservable() {
        addBtn.rx.tap.subscribe(onNext: { _ in
            var count = self.productObj?.selectedCount ?? 0
            count += 1
            self.isSelectedRow(count: count)
        }).disposed(by: disposeBag)
        
        minusBtn.rx.tap.subscribe(onNext: { _ in
            if self.productObj?.selectedCount ?? 0 == 0 { return }
//            self.count -= 1
            var count = self.productObj?.selectedCount ?? 0
            count -= 1
            self.isSelectedRow(count: count)
        }).disposed(by: disposeBag)
        
    }
    
    func isSelectedRow(count: Int) {
        if count == 0 {
            self.checkIcon.isSelected = false
            self.backgroundColor = .white
        } else {
            self.checkIcon.isSelected = true
            self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        self.productObj?.selectedCount = count
        self.countTextField.text = "\(count)"
        self.viewModel?.setAddCartCount(item: productObj!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        checkIcon.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.height.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
       
//        countSelect.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.right.equalTo(-15)
//            make.width.equalToSuperview().multipliedBy(0.15)
//        }
        
        addBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalToSuperview().multipliedBy(0.08)
        }
        
        countTextField.snp.makeConstraints { make in
            make.right.equalTo(addBtn.snp.left)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalToSuperview().multipliedBy(0.13)
        }
        
        minusBtn.snp.makeConstraints { make in
            make.right.equalTo(countTextField.snp.left)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalToSuperview().multipliedBy(0.08)
        }
        
        productPrize.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(minusBtn.snp.left).offset(-10)
            make.width.equalToSuperview().multipliedBy(0.17)
        }
        
        productName.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.left.equalTo(checkIcon.snp.right).offset(10)
            make.right.equalTo(productPrize.snp.left).offset(-10)
            make.bottom.equalTo(-15)
        }
    }
}

//extension QuicklyOrderListCell: UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        numArray.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return String(numArray[row])
//    }
//
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        isSelectedRow(row: row)
//    }
//
//}
