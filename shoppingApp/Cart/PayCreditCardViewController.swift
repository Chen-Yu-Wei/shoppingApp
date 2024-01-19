//
//  PayCreditCardViewController.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/6/20.
//

import UIKit
import ECPayPaymentGatewayKit
import SnapKit
import RxSwift
import RxCocoa

class PayCreditCardViewController: UIViewController {
    let viewModel = PayCreditCardModel()
    let disposeBag = DisposeBag()
    var totalPrice = 0
    var tradeStatus = "0"  // 訂單狀態，0：訂購失敗，1：訂購成功
    var isOrderComplete = false
    
    lazy var resultTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.setData(total: totalPrice)
        
//        addUI()
        
        self.viewModel.tokenObservable
            .subscribe(onNext: { data in
                self.getECPayUI(token: data)
            }).disposed(by: disposeBag)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if isOrderComplete {
            /// 發送訂單完成通知
            let notificationName = Notification.Name("orderCompleteNotifi")
            NotificationCenter.default.post(name: notificationName, object: self, userInfo: ["status" : tradeStatus])
        }
    }
    
    /// 加入UI
    func addUI() {
        view.addSubview(resultTextView)
        resultTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    /// 取得付款畫面
    func getECPayUI(token: String) {
        DispatchQueue.main.async {
            ECPayPaymentGatewayManager.sharedInstance().createPayment(token: token) { state in
                self.resultTextView.text = state.description

                print(state)

                 if state.callbackStateStatus == .Success {
                
                     let state_ = state as! CreatePaymentCallbackState
                     print("CreatePaymentCallbackState:")
                     print(" RtnCode = \(state_.RtnCode)")
                     print(" RtnMsg = \(state_.RtnMsg)")
                     print(" MerchantID = \(state_.MerchantID)")
                     print(" OrderInfo = \(state_.OrderInfo)")
                     print(" CardInfo = \(state_.CardInfo)")
                
                 }

                if let callbackState = state as? CreatePaymentCallbackState {

                    print("CreatePaymentCallbackState:")
                    print("RtnCode = \(callbackState.RtnCode)")
                    print("RtnMsg = \(callbackState.RtnMsg)")

                    if let order = callbackState.OrderInfo {
                        print("\(order)")
                        print("\(order.MerchantTradeNo ?? "")")
                        print("\(order.TradeNo ?? "")")
                        print("\(order.TradeDate)")
                        print("\(order.TradeStatus ?? "0")")
                        self.tradeStatus = order.TradeStatus ?? "0"
                    }
                    if let card = callbackState.CardInfo {
                        print("\(card)")
                        print("\(card.AuthCode ?? "")")
                        print("\(card.Gwsr ?? "")")
                        print("\(card.ProcessDate)")
                        print("\(card.Stage ?? 0)")
                        print("\(card.Stast ?? 0)")
                        print("\(card.Staed ?? 0)")
                        print("\(card.Amount ?? 0)")
                        print("\(card.Eci ?? 0)")
                        print("\(card.Card6No ?? "")")
                        print("\(card.Card4No ?? "")")
                        print("\(card.RedDan ?? 0)")
                        print("\(card.RedDeAmt ?? 0)")
                        print("\(card.RedOkAmt ?? 0)")
                        print("\(card.RedYet ?? 0)")
                    }
                    if let atm = callbackState.ATMInfo {
                        print("\(atm)")
                        print("\(atm.BankCode ?? "")")
                        print("\(atm.vAccount ?? "")")
                        print("\(atm.ExpireDate)")
                    }
                    if let cvs = callbackState.CVSInfo {
                        print("\(cvs)")
                        print("\(cvs.PaymentNo ?? "")")
                        print("\(cvs.ExpireDate)")
                        print("\(cvs.PaymentURL ?? "")")
                    }
                    if let barcode = callbackState.BarcodeInfo {
                        print("\(barcode)")
                        print("\(barcode.ExpireDate)")
                        print("\(barcode.Barcode1 ?? "")")
                        print("\(barcode.Barcode2 ?? "")")
                        print("\(barcode.Barcode3 ?? "")")
                    }
                    if let unionpay = callbackState.UnionPayInfo {
                        print("\(unionpay.UnionPayURL ?? "")")
                    }
                }
                
                let ac = UIAlertController(title: "提醒您", message: "已經 callback，請看 console!", preferredStyle: UIAlertController.Style.alert)
                let aa = UIAlertAction(title: "好", style: UIAlertAction.Style.default, handler: nil)
                ac.addAction(aa)
//                self.present(ac, animated: true, completion: nil)
                self.isOrderComplete = true
                self.dismiss(animated: true)
            }
        }       
    }
}
