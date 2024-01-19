//
//  AppDelegate.swift
//  shoppingApp
//
//  Created by 陳昱維 on 2023/5/30.
//

import UIKit
import ECPayPaymentGatewayKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var envStr:String = "stage"
        if let env = Bundle.main.object(forInfoDictionaryKey: "ENV") as? String {
            envStr = env.lowercased()
        }
        switch envStr {
        case "stage": // 測試環境
            ECPayPaymentGatewayManager.sharedInstance().initialize(env: .Stage)
            break
        default: // 正式環境
            ECPayPaymentGatewayManager.sharedInstance().initialize(env: .Prod)
            break
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

