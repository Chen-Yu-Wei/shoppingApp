//
//  PayCreditCardModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/6/27.
//

import Foundation
import RxSwift

class PayCreditCardModel {
    let payApiUrl = "https://ecpg-stage.ecpay.com.tw/Merchant/GetTokenbyTrade"
    var token: String = ""
    var tokenObservable = PublishSubject<String>()

    init() {}
    
    func setData(total: Int){
        /// 取時間
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let strTime = formatter.string(from: now)
        formatter.dateFormat = "yyyyMMdd"
        let tradeNoTime = formatter.string(from: now)
        
        var num = 0
        var tradeNo = tradeNoTime + "03" // 更改交易序號
        
//        let jsonDecoder = JSONDecoder()
//        if let data = UserDefaults.standard.data(forKey: "tradeNo") {
//            guard let object = try? jsonDecoder.decode(String.self, from: data) else {return}
//            if tradeNo == object {
//                num += 1
//                tradeNo = tradeNoTime + "0\(num)"
//            }
//        }
//        UserDefaults.standard.setValue(tradeNo, forKey: "tradeNo")
        
        let orderInfo = OrderInfoObj(
            MerchantTradeDate: strTime,
            MerchantTradeNo: tradeNo,
            TotalAmount: total,
            ReturnURL: "https://yourReturnURL.com",
            TradeDesc: "交易結果",
            ItemName: "測試商品")
        
        let cardInfo = CardInfoObj(
            OrderResultURL: "https://yourReturnURL.com",
            CreditInstallment: "3,6,12")
        
        let atmInfo = ATMInfoObj(ExpireDate: 3)
        let consumerInfo = ConsumerInfoObj(
            MerchantMemberID: "test123456",
            Email: "customer@email.com",
            Phone: "0912345678",
            Name: "Test",
            CountryCode: "158")
        
        let tradeData = TradeDetailObj(
            MerchantID: "3002607",
            RememberCard: 1,
            PaymentUIType: 2,
            ChoosePaymentList: "1,2,3",
            OrderInfo: orderInfo,
            CardInfo: cardInfo,
            ATMInfo: atmInfo,
            ConsumerInfo: consumerInfo)
        
        getToken(tradeData: tradeData)
    }
    
    func getToken(tradeData: TradeDetailObj) {
        if let url = URL(string: payApiUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let encoder = JSONEncoder()
            let data = try? encoder.encode(tradeData)
            print(String(data: data!, encoding: .utf8)!)
            if let data = data {
                if let dataStr = String(data: data, encoding: .utf8) {
                    // 取代"\"
                    let str = dataStr.replacingOccurrences(of: "\\", with: "")
                    print(str)
                    // url encode
                    let urlEncode = str.addingPercentEncoding(withAllowedCharacters: .urlUserAllowed) ?? ""
                    print(urlEncode)
                    // 加密
                    let encryptedStr = urlEncode.aesEncrypt(key: apiKey, iv: apiIV) ?? ""
                    print(encryptedStr)
                    
                    // 取得目前時間戳
                    let now = Date()
                    let timeInterval = now.timeIntervalSince1970
                    let timeObj = TimeObj(Timestamp: Int(timeInterval))
                    
                    let tradeObj = TradeObj(
                        MerchantID: "3002607",
                        RqHeader: timeObj,
                        Data: encryptedStr)
                    let encodeData = try? encoder.encode(tradeObj)
                    request.httpBody = encodeData
                    
                    URLSession.shared.dataTask(with: request) { (data, response, error) in
                        if let data {
                            do {
                                let decoder = JSONDecoder()
                                let result = try decoder.decode(TradeResObj.self, from: data)
                                print(result)
                                
                                // 解密
                                let decryptedStr = result.Data.aesDecrypt(key: apiKey, iv: apiIV)
                                
                                // url decode
                                let decondData = decryptedStr?.removingPercentEncoding
                                
                                // string轉json
                                let jsonData = decondData?.data(using: .utf8, allowLossyConversion: true)
                                print(String(data: jsonData!, encoding: .utf8))
                                
                                let dataResult = try decoder.decode(TokenObj.self, from: jsonData!)
                                
                                self.token = dataResult.Token
                                
                                print("===========\(self.token)==========")
                                self.tokenObservable.onNext(self.token)
                                
                            } catch {
                                print(error)
                            }
                        }
                    }.resume()
                } else {
                    print("==== ERROR: Why ====")
                }
            } else {
                print("====== ERROR: data is nil ========")
            }
        }
    }
}
