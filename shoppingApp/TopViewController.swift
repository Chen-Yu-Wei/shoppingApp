//
//  TopViewController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/6/7.
//
// 最上方導覽view

import Foundation
import UIKit
import SnapKit
import RxSwift

//protocol TopViewControllerDelegate {
//    // menu欄
//    func toggleMenuPanel()
//}

class TopViewController: UIViewController {
    let disposeBag = DisposeBag()
//    var delegate: TopViewControllerDelegate?
    let badgeSize: CGFloat = 20
    var badgeNum: Int = 0 {
        didSet {
            noticeBadge.text = String(badgeNum)
            noticeBadge.isHidden = badgeNum == 0 ? true : false
            self.view.layoutIfNeeded()
        }
    }
    
    // 側目錄button
//    lazy var menuButton: UIButton = {
//        let button = UIButton()
//        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
//        button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
//        button.setImage(UIImage(systemName: "list.dash"), for: .normal)
//        return button
//    }()
    
    lazy var notificationBtn: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
        button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        return button
    }()
    
    ///通知數量badge
    lazy var noticeBadge: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = badgeSize / 2
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11)
        label.sizeToFit()
        label.clipsToBounds = true
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 1, green: 0.8413081765, blue: 0.6554909945, alpha: 1)
        addUI()
        setUI()
//        setObservable()
    }
    
    func setObservable(){
        // 接收已加入購物車通知
        let notificationName = Notification.Name("addCartNotification")
        _ = NotificationCenter.default.rx
            .notification(notificationName)
            .takeUntil(self.rx.deallocated) //頁面銷毁自動移除通知監聽
            .subscribe(onNext: { notification in
                let userInfo = notification.userInfo as! [String: Int]
                self.badgeNum = userInfo["cartCount"]!
            }).disposed(by: disposeBag)
    }
    
    func setUI() {
//        menuButton.rx.tap
//            .subscribe(onNext: { _ in
//                self.delegate?.toggleMenuPanel()
//            }).disposed(by: disposeBag)
    }
    
    func addUI() {
//        view.addSubview(menuButton)
//
//        menuButton.snp.makeConstraints { make in
//            make.left.equalTo(15)
//            make.height.width.equalTo(30)
//            make.centerY.equalToSuperview()
//        }
        
        view.addSubview(notificationBtn)
        notificationBtn.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.height.width.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(noticeBadge)
        noticeBadge.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.bottom.equalTo(-27)
            make.width.height.equalTo(badgeSize)
        }
    }
}
