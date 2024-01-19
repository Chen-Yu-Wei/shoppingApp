//
//  CartViewController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/6/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class CartViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = CartViewModel()
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(CartViewListCell.self, forCellReuseIdentifier: "CartViewListCell")
        tableview.estimatedRowHeight = 44.0
        tableview.rowHeight = UITableView.automaticDimension
        return tableview
    }()
    
    lazy var noticeTxt: UILabel = {
        let label = UILabel()
        label.text = "目前尚未選購商品"
        label.textAlignment = .center
        return label
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
//        view.backgroundColor = .magenta
        return view
    }()
    
    lazy var totalPrice: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .orange
        return label
    }()
    
    lazy var nextBtn: UIButton = {
        let button = UIButton()
        button.setTitle("結帳", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 3.0
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "購物車"
        // 可以讓navigation bar不遮擋到下面的view controller
        self.navigationController?.navigationBar.isTranslucent = false
        addUI()
        setObservable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchData()
    }
    
    func setObservable() {
        viewModel.cartListObservable.bind(to: tableView.rx.items(cellIdentifier: "CartViewListCell", cellType: CartViewListCell.self)) { (row, element, cell) in
            cell.cartProductObj = element
            cell.addBtn.rx.tap.subscribe(onNext: {
                let quantity = Int(element.quantity)! + 1
                let subtotal = quantity * Int(element.price)!
                let list = CartManager.shared.updateQuantityAndSubTotal(cartItem: element, quantity: String(quantity), subTotal: String(subtotal))
                let total = CartManager.shared.getTotal()
                self.totalPrice.text = "總計：\(total)元"
                self.viewModel.fetchData()
                
            }).disposed(by: cell.disposeBag)
            
            cell.minusBtn.rx.tap.subscribe(onNext: {
                var quantity = Int(element.quantity)!
                if quantity > 1 {
                    quantity -= 1
                    let subtotal = quantity * Int(element.price)!
                    _ = CartManager.shared.updateQuantityAndSubTotal(cartItem: element, quantity: String(quantity), subTotal: String(subtotal))
                    self.setTotal()
                    self.viewModel.fetchData()
                }
                
            }).disposed(by: cell.disposeBag)
            
            cell.deleteBtn.rx.tap.subscribe(onNext: {
                _ = CartManager.shared.remove(cartItem: element)
                self.viewModel.fetchData()
                self.setTotal()
                // 發送刪除商品通知
                let notificationName = Notification.Name("addCartNotification")
                NotificationCenter.default.post(name: notificationName, object: self, userInfo: nil)
            }).disposed(by: cell.disposeBag)
        }.disposed(by: disposeBag)
        
        viewModel.cartListObservable
            .subscribe(onNext: { data in
                if data.count > 0 {
                    self.noticeTxt.isHidden = true
                    self.totalPrice.isHidden = false
                    self.nextBtn.isHidden = false
                } else {
                    self.noticeTxt.isHidden = false
                    self.totalPrice.isHidden = true
                    self.nextBtn.isHidden = true
                }
                self.setTotal()
            }).disposed(by: disposeBag)
        
        nextBtn.rx.tap.subscribe(onNext: { _ in
            let vc = PayCreditCardViewController()
            vc.totalPrice = Int(CartManager.shared.getTotal())!
            self.present(vc, animated: true)
//            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        /// 接收訂單完成通知
        let notificationName = Notification.Name("orderCompleteNotifi")
        _ = NotificationCenter.default.rx
            .notification(notificationName)
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { notification in
                let data = notification.userInfo?["status"] as? String
                if let data = data {
                    if data == "0" {
                        let ac = UIAlertController(title: "提醒您", message: "訂購失敗，請再試一次。", preferredStyle: UIAlertController.Style.alert)
                        let aa = UIAlertAction(title: "好", style: UIAlertAction.Style.default, handler: nil)
                        ac.addAction(aa)
                        self.present(ac, animated: true, completion: nil)
                    } else {
                        // 清空購物車
                        CartManager.shared.cleanCart()
                        self.viewModel.fetchData()
                    }
                }
            }).disposed(by: disposeBag)
    }
    
    /// 取總金額
    func setTotal() {
        let total = CartManager.shared.getTotal()
        self.totalPrice.text = "總計：\(total)元"
    }
}
