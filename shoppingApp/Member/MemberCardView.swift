//
//  MemberCardView.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/12/6.
//

import UIKit
import RxSwift

class MemberCardView: UIView {
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var memberPhoto: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberStatus: PaddingLabel!
    @IBOutlet weak var memberQRcord: UIImageView!
    @IBOutlet weak var amountProgress: UIProgressView!
    @IBOutlet weak var promotionInfo: UILabel!
    
    /// 已消費金額
    var spentAmount: Double = 2200.0
    /// 達標金額
    var totalAmount: Double = 6000.0
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
        setting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
        setting()
    }
 
    func loadXib() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "MemberCardView", bundle: bundle)
        let xibView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        xibView.frame = bounds
        addSubview(xibView)
    }
    
    func setting() {
        backgroundView.layer.cornerRadius = 10
        
        // 會員頭像
        memberPhoto.layer.cornerRadius = memberPhoto.frame.height / 2
        memberPhoto.layer.masksToBounds = true
        
        // 會員階級
        memberStatus.layer.cornerRadius = 6
        memberStatus.layer.masksToBounds = true
        memberStatus.padding(5, 5, 5, 5)
        
        // 進度條
        var ratio = spentAmount / totalAmount
        amountProgress.progress = Float(ratio)
        
        // 升階資訊
        var balance = Int(totalAmount - spentAmount)
        let attributedString = NSMutableAttributedString(string: "再消費\(Int(balance))元可升等成銀卡會員")
        attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: NSMakeRange(3,String(balance).count))
        promotionInfo.attributedText = attributedString
        
        
        let tapGesture = UITapGestureRecognizer()
        memberQRcord.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event.bind(onNext: { recognizer in
            let controller = MemberQRcodeViewController()
//            controller.qrcodeGenerate(text: "103058374")
        }).disposed(by: disposeBag)
    }
}
