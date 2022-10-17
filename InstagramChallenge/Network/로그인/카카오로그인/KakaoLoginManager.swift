//
//  KakaoLoginManager.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/29.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

final class KakaoLoginManager {
    
    static var userNickName: String?
    
    func kakaoLogin(_ delegate: UIViewController) {
        // 카톡이 깔려있는지 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            // 카톡이 있는 경우
            UserApi.shared.loginWithKakaoTalk { (OAuthToken, error) in
                if let error = error {
                    delegate.presentAlert(title: "계정을 찾을 수 없음", message: "로그인에 실패하였습니다.")
                    print("카카오 로그인 실패!! \(error)")
                }
                else {
                    Constant.isUserKakaoLogged = true
                    print("카카오 로그인 성공!! loginWithKakaoTalk() success.")
                    
                    let request = KakaoLoginRequest(accessToken: OAuthToken?.accessToken ?? "")
                    SocialLoginDataManager().postSignIn(request, delegate: delegate)
                    
                    //self.setUserInfo()
                }
            }
        }
        // 카톡이 없는 경우
        else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    delegate.presentAlert(title: "계정을 찾을 수 없음", message: "로그인에 실패하였습니다.")
                    print("카카오 로그인 실패!! \(error)")
                }
                else {
                    Constant.isUserKakaoLogged = true
                    print("카카오 로그인 성공!! loginWithKakaoAccount() success.")
                    
                    let request = KakaoLoginRequest(accessToken: oauthToken?.accessToken ?? "")
                    SocialLoginDataManager().postSignIn(request, delegate: delegate)
                    
                    self.setUserInfo()
                    
                }
            }
        }
    }
    
    // kakao 유저 정보 활용
    func setUserInfo() {
        UserApi.shared.me() { (user, error) in
            if let error = error {
                print(error)
            }else {
                print(user?.kakaoAccount?.profile?.nickname! ?? "")
                print("me() success.")
            }
        }
    }
    
    // kakao 로그아웃
    func kakaoLogout() {
        UserApi.shared.logout { (error) in
            if let error = error {
                print(error)
            }else {
                print("logout() success")
            }
        }
    }
}
