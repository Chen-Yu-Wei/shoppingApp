//
//  NewsListController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/5/31.
//

import UIKit
import RxSwift
import RxCocoa

class NewsListViewController: UIViewController {
    let viewModel = NewsListViewModel()
    let disposeBag = DisposeBag()
    
    lazy var newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NewsCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.title = "最新消息"
        // 可以讓navigation bar不遮擋到下面的view controller
        self.navigationController?.navigationBar.isTranslucent = false
        setData()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setData() {
        self.viewModel.newsListObservable.bind(to: newsTableView.rx.items(cellIdentifier: "NewsCell", cellType: UITableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = element.title
        }.disposed(by: disposeBag)
        
        self.newsTableView.rx.modelSelected(NewsDetailObj.self)
            .subscribe(onNext: { item in
                let vc = NewsDetailViewController()
                vc.newsDetailList = item
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
        
/// 另一種寫法
//        self.viewModel.newsListObservable.bind(to: newsTableView.rx.items) { (tableView, row, element) in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
//            cell?.textLabel?.text = element.title
//            return cell!
//        }.disposed(by: disposeBag)
//
//        self.newsTableView.
    }
    
}
