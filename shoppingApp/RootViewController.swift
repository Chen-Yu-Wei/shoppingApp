//
//  RootViewController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/6/2.
//
// 底層view

import UIKit
import SnapKit

enum PanelState {
    // 關閉
    case close
    // 購物車欄打開
//    case cartPanelExpand
    // 側目錄欄打開
    case menuExpand
}

enum MenuOptionID: String {
    case ID_News =  "menu_news"
    case ID_QuickOrder = "menu_quickOrder"
    case ID_Favorite = "menu_favorite"
    case ID_Guide = "menu_app-guide"
    case ID_Service = "menu_service-locations"
}

class RootViewController: UIViewController {
    
    let tabbarController = TabbarController()
    let topVC = TopViewController()
    let menuVC = MenuViewController()
    let newsVC = NewsListViewController()
    let quicklyOrderVC = QuicklyOrderViewController()
    let favoriteVC = FavoritesViewController()
    /// 目前側邊欄狀態
    var currentPanelStatus: PanelState = .close
    
    /// 最上方導覽view
    lazy var topView: UIView = {
        let view = topVC.view!
        return view
    }()
    
    lazy var tabbarView: UIView = {
        let view = tabbarController.view!
        return view
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        addChildVC()
//        topVC.delegate = self
//        menuVC.delegate = self
        self.navigationItem.backButtonTitle = ""
        tabbarController.rootViewController = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func addChildVC() {
        addVC(child: tabbarController)
        addVC(child: topVC)
        
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(topPadding)
            make.height.equalTo(50)
            make.centerX.equalToSuperview().offset(0)
            make.width.equalToSuperview()
        }
        
        tabbarView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalTo(-bottomPadding)
            make.centerX.equalToSuperview().offset(0)
            make.width.equalToSuperview()
        }

    }
}

// MARK: -TopViewControllerDelegate
//extension RootViewController: TopViewControllerDelegate {
//
//    func toggleMenuPanel() {
//        if currentPanelStatus == .menuExpand {
//            UIView.animate(withDuration: 0.5 , delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
//                self.topView.snp.updateConstraints { make in
//                    make.centerX.equalToSuperview().offset(0)
//                }
//
//                self.tabbarView.snp.updateConstraints { make in
//                    make.centerX.equalToSuperview().offset(0)
//                }
//                self.view.layoutIfNeeded()
//            }, completion: { _ in
//                self.menuVC.removeVC()
//                self.currentPanelStatus = .close
//            })
//        } else {
//            addChild(menuVC)
//            self.view.insertSubview(self.menuVC.view, at: 0)
//            menuVC.didMove(toParent: self)
//
//            menuVC.view.snp.makeConstraints { make in
//                make.bottom.equalTo(-bottomPadding)
//                make.top.equalTo(topPadding)
//                make.leading.trailing.equalToSuperview()
//            }
//
//            // 先讓menuVC的位置固定，避免產生動畫效果
//            self.view.layoutIfNeeded()
//
//            let width = self.menuVC.view.frame.width
//            self.topView.snp.updateConstraints { make in
//                make.centerX.equalToSuperview().offset(width - 90)
//            }
//
//            self.tabbarView.snp.updateConstraints { make in
//                make.centerX.equalToSuperview().offset(width - 90)
//            }
//
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
//                self.view.layoutIfNeeded()
//            }, completion: { _ in
//                self.currentPanelStatus = .menuExpand
//            })
//        }
//    }
//}

// MARK: - MenuViewControllerDelegate
//extension RootViewController: MenuViewControllerDelegate {
//    func tapMenuCell(id: MenuOptionID) {
//        switch id {
//        case .ID_News:
//            self.navigationController?.pushViewController(newsVC, animated: true)
//        case .ID_QuickOrder:
//            self.navigationController?.pushViewController(quicklyOrderVC, animated: true)
//            quicklyOrderVC.viewModel.topViewController = self.topVC
//        case .ID_Favorite:
//            self.navigationController?.pushViewController(favoriteVC, animated: true)
//        case .ID_Guide:
//            break
//        case .ID_Service:
//            break
//        }
//
//        self.topView.snp.updateConstraints { make in
//            make.centerX.equalToSuperview().offset(0)
//        }
//
//        self.tabbarView.snp.updateConstraints { make in
//            make.centerX.equalToSuperview().offset(0)
//        }
//        self.currentPanelStatus = .close
//    }
//}
