//
//  MemberQRcodeViewController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/12/12.
//

import UIKit
import RxSwift

class MemberQRcodeViewController: UIViewController {
    lazy var maskView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.7)
        return view
    }()
    
    lazy var basicView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ｘ", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var switchSegmented: UISegmentedControl = {
        let seg = UISegmentedControl(items: ["一維條碼","二維條碼"])
        seg.addTarget(self, action: #selector(changeQRcord), for: .valueChanged)
        seg.selectedSegmentIndex = 0
        return seg
    }()
    
    lazy var QRcodeImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.addUI()
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.qrcodeGenerate(text: "103058374")
    }
    
    @objc func changeQRcord() {
        // QRcode
        if switchSegmented.selectedSegmentIndex == 0 {
            QRcodeImage.image = UIImage()
            qrcodeGenerate(text: "103058374")
        }
        // barCode
        else {
            QRcodeImage.image = UIImage()
            barcodeGenerate(text: "103058374")
        }
    }
    
    func setUI() {
        closeButton.rx.tap
            .subscribe(onNext: { _ in
                self.view.removeFromSuperview()
            }).disposed(by: disposeBag)
    }
    
    func qrcodeGenerate(text: String) {
        var qrcodeImage: CIImage?
        let data = text.data(using: .isoLatin1)
        let qrfilter = CIFilter(name: "CIQRCodeGenerator")
        qrfilter?.setValue(data, forKey: "inputMessage")
        qrfilter?.setValue("H", forKey:"inputCorrectionLevel")
        qrcodeImage = qrfilter?.outputImage
        
        QRcodeImage.snp.remakeConstraints { make in
            make.top.equalTo(switchSegmented.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(basicView.snp.width).multipliedBy(0.6)
            make.bottom.equalTo(-20)
        }
        
        displayQRCodeImage(ciImage: qrcodeImage)
    }
    
    func barcodeGenerate(text: String) {
        var qrcodeImage: CIImage?
        let data = text.data(using: .isoLatin1)
        let qrfilter = CIFilter(name: "CICode128BarcodeGenerator")
        qrfilter?.setValue(data, forKey: "inputMessage")
        qrcodeImage = qrfilter?.outputImage
        
        QRcodeImage.snp.remakeConstraints { make in
            make.top.equalTo(switchSegmented.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(basicView.snp.width).multipliedBy(0.4)
            make.bottom.equalTo(-20)
        }
        displayQRCodeImage(ciImage: qrcodeImage)
    }
    
    /// 調整解析度
    func displayQRCodeImage(ciImage: CIImage?) {
        // UIImage的長寬和qrcode的CIImage輸出之後的大小相除取得一個調整大小的比例值
        if let resizeImage = ciImage {
            let scaleX = QRcodeImage.frame.size.width / resizeImage.extent.size.width
            let scaleY = QRcodeImage.frame.size.height / resizeImage.extent.size.height
            // 取得調整後的圖片大小，用CGAffineTransform去做縮放
            let transformedImage = resizeImage.transformed(by: CGAffineTransform(scaleX: scaleX, y: scaleY))
            // 將結果顯示到UIImage上
            QRcodeImage.image = UIImage(ciImage: transformedImage)
        }
    }
}
