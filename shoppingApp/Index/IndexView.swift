//
//  IndexView.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/7.
//

import UIKit
import SnapKit

extension IndexViewController {
    //FIXME: 讓tableview的高度符合contentSize，此寫法會讀取到contentSize為0的情況，進而導致cell的data無法寫入，目前先固定tableView高度
//    override func viewDidLayoutSubviews() {
//        newsTableView.layoutIfNeeded()
//        newsTableView.snp.updateConstraints { make in
//            make.height.equalTo(newsTableView.contentSize.height)
//        }
//    }
    
    func setUI() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(self.view)
        }
        
        contentView.addSubview(bannerView)
        bannerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(self.view).multipliedBy(0.35)
        }
        
        // banner block
        bannerView.addSubview(bannerCollectionView)
        bannerCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bannerView.addSubview(bannerPageCotroll)
        bannerPageCotroll.snp.makeConstraints { make in
            make.bottom.equalTo(-10)
            make.centerX.equalToSuperview()
        }
        
        // news block
        contentView.addSubview(newsView)
        newsView.snp.makeConstraints { make in
            make.top.equalTo(bannerView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        newsView.addSubview(newsTitle)
        newsTitle.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.left.equalTo(15)
        }
        
        newsView.addSubview(newsMoreBtn)
        newsMoreBtn.snp.makeConstraints { make in
            make.bottom.equalTo(newsTitle)
            make.right.equalTo(-15)
            make.left.equalTo(newsTitle.snp.right).priorityLow()
        }
        
        newsView.addSubview(newsTableView)
        newsTableView.snp.makeConstraints { make in
            make.top.equalTo(newsTitle.snp.bottom).offset(5)
            make.trailing.leading.bottom.equalToSuperview()
            make.height.equalTo(230)
        }
        
        // sale block
        contentView.addSubview(saleProductView)
        saleProductView.snp.makeConstraints { make in
            make.top.equalTo(newsView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        saleProductView.addSubview(saleTitle)
        saleTitle.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(15)
        }
        
        saleProductView.addSubview(saleTimerView)
        saleTimerView.snp.makeConstraints { make in
            make.centerY.equalTo(saleTitle)
            make.right.equalTo(-15)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        saleProductView.addSubview(saleProductCollectionView)
        saleProductCollectionView.snp.makeConstraints { make in
            make.top.equalTo(saleTitle.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(230)
        }
        
        // vedio block
        contentView.addSubview(vedioView)
        vedioView.snp.makeConstraints { make in
            make.top.equalTo(saleProductView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(self.view).multipliedBy(0.3)
            make.bottom.equalTo(-10)
        }
    }
}
