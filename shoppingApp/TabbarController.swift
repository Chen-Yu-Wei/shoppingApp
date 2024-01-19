//
//  ViewController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/5/30.
//

import UIKit
import RxSwift

class TabbarController: UITabBarController {
    var rootViewController: RootViewController?
    let disposeBag = DisposeBag()
    let badgeSize: CGFloat = 20
    var badgeNum: Int = 0 {
        didSet {
            cartBadge.text = String(badgeNum)
            cartBadge.isHidden = badgeNum == 0 ? true : false
            self.view.layoutIfNeeded()
        }
    }
    
    ///購物車數量badge
    lazy var cartBadge: UILabel = {
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
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUI()
        setObservable()
    }
    
    func setUI() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = #colorLiteral(red: 0.9979724288, green: 0.8412232995, blue: 0.6549820304, alpha: 1)
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
            self.tabBar.isTranslucent = false
        } else {
            self.tabBar.backgroundColor = #colorLiteral(red: 0.9979724288, green: 0.8412232995, blue: 0.6549820304, alpha: 1)
            self.tabBar.isTranslucent = false
        }

        // 加陰影
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: -10)
        self.tabBar.layer.shadowOpacity = 0.3
        self.tabBar.layer.shadowRadius = 10
        
        view.addSubview(cartBadge)
        cartBadge.snp.makeConstraints { make in
            make.right.equalTo(-screenWidth / 5 - 10)
            make.bottom.equalTo(-27)
            make.width.height.equalTo(badgeSize)
        }
      
        creatVC()
    }
    
    func setObservable(){
        // 接收已加入購物車通知
        let notificationName = Notification.Name("addCartNotification")
        _ = NotificationCenter.default.rx
            .notification(notificationName)
            .takeUntil(self.rx.deallocated) //頁面銷毁自動移除通知監聽
            .subscribe(onNext: { notification in
//                let userInfo = notification.userInfo as! [String: Int]
                let list = CartManager.shared.shoppingList
                self.badgeNum = list.count
            }).disposed(by: disposeBag)
        
        /// 接收訂單完成通知
        let notificationNamee = Notification.Name("orderCompleteNotifi")
        _ = NotificationCenter.default.rx
            .notification(notificationNamee)
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { _ in
                // 回到首頁
                self.selectedIndex = 2
                self.badgeNum = 0
            }).disposed(by: disposeBag)
    }

    // MARK: -設定tabbar頁面
    func creatVC() {
        // 首頁
        let indexController = IndexViewController()
        let indexNavi = UINavigationController(rootViewController: indexController)
        indexNavi.tabBarItem.image = UIImage(systemName: "house")
        indexNavi.tabBarItem.title = "首頁"
        
        // 商品
        let productController = ProductListViewController()
        let productNavi = UINavigationController(rootViewController: productController)
        productNavi.tabBarItem.image = UIImage(systemName: "poweroutlet.type.h.fill")
        productNavi.tabBarItem.title = "商品"
        
        // 會員專區
        let memberServiceController = MemberServiceViewController()
        let memberNavi = UINavigationController(rootViewController: memberServiceController)
        memberNavi.tabBarItem.image = UIImage(systemName: "person")
        memberNavi.tabBarItem.title = "會員專區"
        
        // 快速訂購
        let quickController = QuicklyOrderViewController()
        let quickNavi = UINavigationController(rootViewController: quickController)
        quickNavi.tabBarItem.image = UIImage(systemName: "basket")
        quickNavi.tabBarItem.title = "快速訂購"
        
        // 購物車
        let CartController = CartViewController()
        let cartNavi = UINavigationController(rootViewController: CartController)
        cartNavi.tabBarItem.image = UIImage(systemName: "cart")
        cartNavi.tabBarItem.title = "購物車"
        
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
//            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            appearance.shadowColor = nil
            appearance.backgroundColor = #colorLiteral(red: 0.9979724288, green: 0.8412232995, blue: 0.6549820304, alpha: 1)
            appearance.setBackIndicatorImage(UIImage(systemName: "arrow.left"), transitionMaskImage: UIImage(systemName: "arrow.left"))
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().tintColor = .white
        } else {
            indexNavi.navigationBar.isTranslucent = false
            indexNavi.navigationBar.backgroundColor = #colorLiteral(red: 0.9979724288, green: 0.8412232995, blue: 0.6549820304, alpha: 1)
            
        }
        
        viewControllers = [productNavi, quickNavi, indexNavi, cartNavi, memberNavi]
        // 預設頁面是首頁
        self.selectedIndex = 2
    }

}

