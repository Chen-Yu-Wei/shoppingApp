//
//  ProductListViewController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/7.
//

import UIKit
import RxSwift
import RxCocoa

class ProductListViewController: UIViewController {
    let viewModel = ProductListViewModel()
    let disposeBag = DisposeBag()
    
    lazy var productCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: (screenWidth - 30) / 2, height: 230)
//        layout.estimatedItemSize = CGSize(width: (screenWidth - 30) / 2, height: 50)
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 10

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductCellViewController.self, forCellWithReuseIdentifier: "productCell")
        collectionView.backgroundColor = .white
//        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "商品"
        
        setUI()
        setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setData() {
        //collectionView cell綁定
        self.viewModel.productListObservable.bind(to: productCollectionView.rx.items(cellIdentifier: "productCell", cellType: ProductCellViewController.self)) { (row, item, cell) in
            cell.productObj = item
        }.disposed(by: disposeBag)
        
        self.productCollectionView.rx.modelSelected(ProductObj.self)
            .subscribe(onNext: { item in
                let vc = ProductDetailViewController()
                vc.productObj = item
                self.navigationController?.pushViewController(vc, animated: false)
            }).disposed(by: disposeBag)
    }
}

//extension ProductListViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.productList.count
//    }
//}

