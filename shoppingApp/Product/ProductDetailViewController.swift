//
//  ProductDetailViewController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/7.
//

import UIKit
import RxSwift
import RxCocoa

class ProductDetailViewController: UIViewController {
    var productObj: ProductObj?
    var disposeBag = DisposeBag()
    let viewModel = ProductDetailViewModel()
//    let productCount = BehaviorRelay<String>(value: "")
    var count = 0
    
    // 製作左右滑動商品圖
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray
        return image
    }()
    
    lazy var shareBtn: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var productName: UILabel = {
        let label = UILabel()
        label.text = productObj?.name
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 19)
        return label
    }()
    
    lazy var productPrice: UILabel = {
        let label = UILabel()
        label.text = "NT$" + String(productObj?.price ?? 0)
        return label
    }()
    
//    lazy var productDescTitle: UILabel = {
//        let label = UILabel()
//        return label
//    }()
    
    lazy var productDesc: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "商品詳情：\n" + (productObj?.description ?? "")
        return label
    }()
    
    lazy var addBtn: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = .lightGray
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
        button.backgroundColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        return button
    }()
    
    lazy var addCartBtn: UIButton = {
        let button = UIButton()
        button.setTitle("加入購物車", for: .normal)
        button.backgroundColor = .brown
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setObservable()
        setUI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 重置背景和陰影颜色
        appearance.backgroundColor = .clear
        appearance.shadowColor = nil
        appearance.setBackIndicatorImage(UIImage(systemName: "arrow.left"), transitionMaskImage: UIImage(systemName: "arrow.left"))
        self.navigationController?.navigationBar.backItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
       
    }
    
    func setObservable() {
        addBtn.rx.tap.subscribe(onNext: { _ in
            self.count += 1
            self.countTextField.text = String(self.count)
            self.productObj?.selectedCount = self.count
        }).disposed(by: disposeBag)
        
        minusBtn.rx.tap.subscribe(onNext: { _ in
            if self.count == 0 { return }
            self.count -= 1
            self.countTextField.text = String(self.count)
            self.productObj?.selectedCount = self.count
        }).disposed(by: disposeBag)
        
        addCartBtn.rx.tap.subscribe(onNext: { [self] _ in
            if self.countTextField.text == "0" {
                let controller = UIAlertController(title: "尚未選擇商品", message: "", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                controller.addAction(okAction)
                self.present(controller, animated: true)
            } else {
                self.viewModel.addCartItem(obj: self.productObj!)
            }
        }).disposed(by: disposeBag)
        
        self.viewModel.addCartSuccessObservable
            .subscribe(onNext: { _ in
                self.view.showToast(text: "已加入購物車！")
                self.count = 0
                self.countTextField.text = String(self.count)
                self.productObj?.selectedCount = self.count
            }).disposed(by: disposeBag)
        
    }
    
}
