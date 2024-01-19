//
//  MenuViewController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/6/26.
//

import UIKit
import RxSwift
import RxCocoa

protocol MenuViewControllerDelegate {
    func tapMenuCell(id: MenuOptionID)
}

class MenuViewController: UIViewController {
    let viewModel = MenuViewModel()
    let disposeBag = DisposeBag()
    var delegate: MenuViewControllerDelegate?
    var menuList = [MenuDetailObj]()
    
    lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        tableview.backgroundColor = .white
        return tableview
    }()
    
    lazy var logoutBtn: UIButton = {
        let button = UIButton()
        button.setTitle("登出", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setUI()
    }
    
    func setData() {
        self.viewModel.menuListObservable.bind(to: tableView.rx.items(cellIdentifier: "MenuCell", cellType: UITableViewCell.self)) {
            (row, element, cell) in
            cell.textLabel?.text = element.title
            cell.imageView?.image = UIImage(systemName: element.image)
        }.disposed(by: disposeBag)
        
        self.viewModel.menuListObservable
            .subscribe(onNext: { data in
                self.menuList = data
            }).disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                print("選中的選項為：\(indexPath)")
                self.delegate?.tapMenuCell(id: MenuOptionID(rawValue: self.menuList[indexPath.row].ID) ?? .ID_News)
            }).disposed(by: disposeBag)
    }
    
    
}
