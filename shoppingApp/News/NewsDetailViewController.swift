//
//  NewsDetailViewController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/6/16.
//

import UIKit

class NewsDetailViewController: UIViewController {
    var newsDetailList: NewsDetailObj?
    
    // 標題
    lazy var headLine: UILabel = {
        let label = UILabel()
        label.text = newsDetailList?.title
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    // 公告時間
    lazy var date: UILabel = {
        let label = UILabel()
        label.text = newsDetailList?.date
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    // 公告內容
    lazy var content: UITextView = {
        let textView = UITextView()
        textView.text = newsDetailList?.content
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.isEditable = false
        textView.removeTextPadding()
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUI()
    }
}
