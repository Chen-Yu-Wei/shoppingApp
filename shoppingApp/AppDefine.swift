//
//  AppDefine.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/5/31.
//

import UIKit

let screenSize = UIScreen.main.bounds
let screenHeight = screenSize.height
let screenWidth = screenSize.width

// 取得safeArea上下邊距
let window = UIApplication.shared.windows.first
//let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
let topPadding = window?.safeAreaInsets.top ?? 0
let bottomPadding = window?.safeAreaInsets.bottom ?? 0

// 綠界ECPay取token api的金鑰
let apiKey = "pwFHCqoQZGmho4w6"
let apiIV = "EkRm7iFT261dpevs"

