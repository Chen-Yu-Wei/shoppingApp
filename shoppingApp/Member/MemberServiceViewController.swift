//
//  MemberServiceController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/5/31.
//

import UIKit
import RxSwift
import RxCocoa

class MemberServiceViewController: UIViewController {
    
    lazy var memberCardView: MemberCardView = {
        let view = MemberCardView()
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (screenWidth - 30) / 3 - 20, height: 75)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 15
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MemberCell")
        view.isScrollEnabled = false
        view.layer.cornerRadius = 10
        return view
    }()
    
    let viewModel = MemberServiceViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        self.title = "會員專區"
        self.navigationController?.navigationBar.isTranslucent = false
        self.view.backgroundColor = #colorLiteral(red: 0.9405614734, green: 0.9405614734, blue: 0.9405614734, alpha: 1)
        setData()
        setUI()
    }
    
    func setData() {
        self.viewModel.memberMenuListObservable.bind(to: collectionView.rx.items(cellIdentifier: "MemberCell", cellType: UICollectionViewCell.self)) { (row, element, cell) in
//            cell.backgroundColor = .systemGray
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.bounds.size.width, height: cell.bounds.size.height * 0.5))
            imageView.image = UIImage(systemName: element.image)
            imageView.tintColor = #colorLiteral(red: 0.1292613745, green: 0.1292613745, blue: 0.1292613745, alpha: 1)
            imageView.contentMode = .scaleAspectFit
            cell.contentView.addSubview(imageView)
            
            let title = UILabel(frame: CGRect(x: 0, y: imageView.bounds.size.height, width: cell.bounds.size.width, height: 25))
            title.text = element.title
            title.textAlignment = .center
            cell.contentView.addSubview(title)
            
        }.disposed(by: disposeBag)
    }
}
