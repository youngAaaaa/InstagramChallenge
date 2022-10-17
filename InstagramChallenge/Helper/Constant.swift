//
//  Constant.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/28.
//

import Foundation

struct Constant {
    
    // jwt토큰 유효성검사를 동기적으로 처리하기 위한 세마포어
    static let semaphore = DispatchSemaphore(value: 0)
    
    // 로그인 상태 여부
    static var isUserLogged: Bool = false
    
    // 소셜 로그인 상태 여부
    static var isUserKakaoLogged: Bool = false
    
    // API호출 기본 url
    static let requestURL = "https://challenge-api.gridge.co.kr"
    
    static let moreURL = "https://gridgetest.oopy.io"
    
    static var loginID: String?
    static var jwt: String?
    
    // 카카오 로그인 성공하면 저장할 값
    static var kakaoOauthToken: String?
    
    
}
