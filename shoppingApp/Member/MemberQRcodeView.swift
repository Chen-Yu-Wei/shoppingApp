//
//  MemberQRcodeView.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/12/12.
//

import UIKit

extension MemberQRcodeViewController {
    func addUI() {
        guard let window = UIApplication.shared.connectedScenes
            .flatMap({ ($0 as? UIWindowScene)?.windows ?? [] })
            .last(where: { $0.isKeyWindow }) else {
            return
        }
        
        window.addSubview(view)
        window.bringSubviewToFront(view)
        view.frame = window.bounds
        
        view.addSubview(maskView)
        maskView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(basicView)
        basicView.snp.makeConstraints { make in
            make.center.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        basicView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.width.height.equalTo(30)
        }
        
        basicView.addSubview(switchSegmented)
        switchSegmented.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        basicView.addSubview(QRcodeImage)
        QRcodeImage.snp.makeConstraints { make in
            make.top.equalTo(switchSegmented.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(basicView.snp.width).multipliedBy(0.6)
            make.bottom.equalTo(-20)
        }
    }
}
