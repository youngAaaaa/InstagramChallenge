//
//  AppDelegate.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/25.
//

import UIKit
import KakaoSDKCommon
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        KakaoSDK.initSDK(appKey: "6bf3b9bbc353619381411d68b9ac3a7d")
        
        FirebaseApp.configure()
        
        Constant.loginID = UserDefaults.standard.string(forKey: "userID")
        Constant.jwt = UserDefaults.standard.string(forKey: "jwt")
        print("‼️Constant.loginID : \(Constant.loginID ?? "로그인 경험 엑스")")
        print("‼️Constant.jwt : \(Constant.jwt ?? "로그인 경험 엑스")")
        AutoSignInDataManager().jwtCheck()
        Constant.semaphore.wait()
        
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

