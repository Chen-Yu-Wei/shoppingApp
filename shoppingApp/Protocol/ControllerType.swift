//
//  ControllerType.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/5/31.
//
//

import RxSwift

protocol ControllerType {
    associatedtype viewModelType
    var disposeBag: DisposeBag { get }
    
    func configure(with viewModel: viewModelType)
    
    func creat(with viewModel: viewModelType) -> UIViewController
    
    func configureView()
}
