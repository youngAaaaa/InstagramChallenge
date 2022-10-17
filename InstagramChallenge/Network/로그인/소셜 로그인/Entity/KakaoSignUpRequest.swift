//
//  KakaoSignUpRequest.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/08/02.
//

import Foundation

// MARK: - KakaoSignUpRequest
struct KakaoSignUpRequest: Encodable {
    let accessToken: String
    let realName: String
    let loginId: String
    let birthDate: String
    let phoneNumber: String
}
