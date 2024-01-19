//
//  QuicklyViewController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/5/31.
//

import UIKit
import RxSwift
import RxCocoa

class QuicklyOrderViewController: UIViewController {
    
    let viewModel = QuicklyOrderViewModel()
    let disposeBag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(QuicklyOrderListCell.self, forCellReuseIdentifier: "QuicklyOrderListCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50.0
        return tableView
    }()
    
    lazy var addBtn: UIButton = {
        let button = UIButton()
        button.setTitle("加入購物車", for: .normal)
        button.backgroundColor = .brown
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        self.title = "快速訂購"
        setUI()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setData() {
        self.viewModel.productListObservable.bind(to: tableView.rx.items(cellIdentifier: "QuicklyOrderListCell", cellType: QuicklyOrderListCell.self)) { (row, element, cell) in
            cell.productObj = element
            cell.viewModel = self.viewModel
            cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }.disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                let cell = self.tableView.cellForRow(at: indexPath) as? QuicklyOrderListCell
                if let cell = cell {
                    cell.checkIcon.isSelected = !cell.checkIcon.isSelected
                    if cell.checkIcon.isSelected {
                        cell.isSelectedRow(count: 1)
                    } else {
                        cell.isSelectedRow(count: 0)
                    }
                    
                }
            }).disposed(by: disposeBag)
        
        self.viewModel.addCartCountObservable
            .subscribe(onNext: { data in
                self.addBtn.setTitle(data, for: .normal)
            }).disposed(by: disposeBag)
        
        self.viewModel.addCartSuccessObservable
            .subscribe(onNext: { _ in
                self.view.showToast(text: "已加入購物車！")
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        self.addBtn.rx.tap
            .subscribe(onNext: { _ in
                if self.viewModel.addCartList.count > 0 {
                    self.viewModel.addCartItem()
                } else {
                    let controller = UIAlertController(title: "尚未選擇商品", message: "", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default)
                    controller.addAction(okAction)
                    self.present(controller, animated: true)
                }
            }).disposed(by: disposeBag)
    }
}
