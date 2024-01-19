//
//  PayModel.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/6/27.
//

import Foundation

// MARK: - 傳給api的Json
struct TradeObj: Codable {
    /// 特店編號
    let MerchantID: String
    /// 傳輸資料
    let RqHeader: TimeObj
    /// 加密資料
    let Data: String
}

struct TimeObj: Codable {
    /// 傳輸時間
    let Timestamp: Int
}

struct TradeDetailObj: Codable {
    /// 特店編號
    let MerchantID: String
    /// 是否使用記憶卡號，0 : 否 / 1 : 是
    let RememberCard: Int
    /// 付款畫面呈現方式，0 : 信用卡定期定額 / 2 : 付款選擇清單頁
    let PaymentUIType: Int
    /// 付款選擇清單頁的清單項目，ex.1,2,3
    /// 0 : 全部付款方式
    /// 1 : 信用卡一次付清
    /// 2 : 信用卡分期付款
    /// 3 : ATM
    /// 4 : 超商代碼
    /// 5 : 超商條碼
    /// 6 : 銀聯卡
    /// 7 : Apple Pay
    /// 8 : 信用卡圓夢彈性分期
    let ChoosePaymentList: String
    /// 訂單資訊
    let OrderInfo: OrderInfoObj
    /// 信用卡資訊
    let CardInfo: CardInfoObj
    /// ATM資訊
    let ATMInfo: ATMInfoObj
    /// 消費者資訊
    let ConsumerInfo: ConsumerInfoObj
}

struct OrderInfoObj: Codable {
    /// 特店交易時間
    let MerchantTradeDate: String
    /// 特店訂單編號
    let MerchantTradeNo: String
    /// 交易金額
    let TotalAmount: Int
    /// 付款回傳結果
    let ReturnURL: String
    /// 交易描述
    let TradeDesc: String
    /// 商品名稱
    let ItemName: String
}

struct CardInfoObj: Codable {
    /// 3D驗證回傳付款結果網址
    let OrderResultURL: String
    /// 刷卡分期期數
    let CreditInstallment: String
}

struct ATMInfoObj: Codable {
    /// 允許繳費有效天數
    let ExpireDate: Int
}

struct ConsumerInfoObj: Codable {
    /// 消費者會員編號
    let MerchantMemberID: String
    /// 信用卡持卡人電子信箱
    let Email: String
    /// 信用卡持卡人電話
    let Phone: String
    /// 信用卡持卡人姓名
    let Name: String
    /// 國別碼（臺灣請填寫 158）
    let CountryCode: String
}

// MARK: - 回傳的Json
struct TradeResObj: Codable {
    /// 特店編號
    let MerchantID: String
    /// 回傳資料
    let RpHeader: TimeObj
    /// 加密資料
    let Data: String
    /// 回傳代碼
    let TransCode: Int
    /// 回傳訊息
    let TransMsg: String
}

struct TokenObj: Codable {
    /// 交易狀態
    let RtnCode: Int
    /// 回應訊息
    let RtnMsg: String
    /// 平台商編號
    let PlatformID: String?
    /// 特店編號
    let MerchantID: String
    /// 交易代碼
    let Token: String
    /// 交易代碼到期時間
    let TokenExpireDate: String
}

