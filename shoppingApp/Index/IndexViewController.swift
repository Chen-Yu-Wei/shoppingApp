//
//  IndexViewController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/7/7.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation
import AVKit
import SnapKit

class IndexViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    /// banner區塊
    lazy var bannerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight * 0.3)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .zero
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(IndexBannerCell.self, forCellWithReuseIdentifier: "bannerCell")
        collectionView.backgroundColor = #colorLiteral(red: 0.5136713386, green: 0.8787359595, blue: 0.8201002479, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // TODO: pageCotroll目前只配合自動輪播，手動輪播尚未同步
    lazy var bannerPageCotroll: UIPageControl = {
        let pageControll = UIPageControl()
        pageControll.numberOfPages = numberArray.count - 1
        return pageControll
    }()
    
    /// 最新消息區塊
    lazy var newsView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var newsTitle: UILabel = {
        let label = UILabel()
        label.text = "最新消息"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    lazy var newsMoreBtn: UIButton = {
        let button = UIButton()
        button.setTitle("查看更多消息 > ", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    lazy var newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    /// 限時特賣區塊
    lazy var saleProductView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.6937219501, blue: 0.8872455955, alpha: 0.2809654387)
        return view
    }()
    
    lazy var saleTitle: UILabel = {
        let label = UILabel()
        label.text = "限時特賣！"
//        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    
    lazy var saleTimerView: CountDownTimer = {
        let view = CountDownTimer()
        view.startTimer()
        return view
    }()
    
    lazy var saleProductCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: screenWidth / 4, height: 50)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProductSaleCell.self, forCellWithReuseIdentifier: "ProductSaleCell")
        collectionView.backgroundColor = .clear
//        collectionView.backgroundColor = #colorLiteral(red: 0.9694301486, green: 0.9734310508, blue: 1, alpha: 0)
        return collectionView
    }()
    
    /// 影片區塊
    lazy var vedioView: UIView = {
        let view = UIView()
        return view
    }()
    
    let disposeBag = DisposeBag()
    let viewModel = IndexViewModel()
    let numberArray = ["1","2","3","4","5","1"]
    var imageIndex = 0
    var loopPlayer: AVPlayerLooper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .lightGray
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // 每兩秒會呼叫一次changeBanner
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(changeBanner), userInfo: nil, repeats: true)
        
        setUI()
        setObservable()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        playVedio()
    }
    
    @objc func changeBanner() {
        imageIndex += 1
        if imageIndex < numberArray.count {
            bannerCollectionView.scrollToItem(at: IndexPath(item: imageIndex, section: 0), at: .centeredHorizontally, animated: true)
            bannerPageCotroll.currentPage = imageIndex
            if imageIndex == (numberArray.count - 1) {
                bannerPageCotroll.currentPage = 0
            }
        } else if imageIndex == numberArray.count {
            imageIndex = 0
            bannerPageCotroll.currentPage = 0
            bannerCollectionView.scrollToItem(at: IndexPath(item: imageIndex, section: 0), at: .centeredHorizontally, animated: false)
            changeBanner()
        }
    }
    
    func setObservable() {
        self.viewModel.productListObservable.bind(to: saleProductCollectionView.rx.items(cellIdentifier: "ProductSaleCell", cellType: ProductSaleCell.self)) {
            (row, item, cell) in
            cell.productObj = item
        }.disposed(by: disposeBag)
        
        self.viewModel.newsListObservable.bind(to: newsTableView.rx.items(cellIdentifier: "NewsCell", cellType: UITableViewCell.self)) { (row, item, cell) in
            if #available(iOS 14, *) {
                var content = cell.defaultContentConfiguration()
                content.text = item.title
//                content.secondaryText = item.date
                cell.contentConfiguration = content
            } else {
                cell.textLabel?.text = item.title
            }
            cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        }.disposed(by: disposeBag)
    }
    
    func playVedio() {
        if let fileUrl = Bundle.main.path(forResource: "bennyMovie", ofType: "mp4") {
            let vedioUrl: URL?
            if #available(iOS 16.0, *) {
                vedioUrl = URL(filePath: fileUrl)
            } else {
                vedioUrl = URL(fileURLWithPath: fileUrl)
            }
            let player = AVQueuePlayer()
            let item = AVPlayerItem(url: vedioUrl!)
            self.loopPlayer = AVPlayerLooper(player: player, templateItem: item)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = self.vedioView.bounds
            self.vedioView.layer.addSublayer(playerLayer)
            player.play()
        }
    }
}

extension IndexViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! IndexBannerCell
        cell.imageView.image = UIImage(systemName: "\(numberArray[indexPath.item]).circle.fill")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        //ceil: 向上取整，也就是只要小数部分不为 0，就取整数部分 + 1
//        let currentPage = ceil(scrollView.contentOffset.x /  scrollView.bounds.size.width)
//        bannerPageCotroll.currentPage = Int(currentPage)
////        bannerPageCotroll.backgroundStyle = .prominent
//        bannerPageCotroll.numberOfPages = numberArray.count
//    }
}
