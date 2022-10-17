//
//  KakaoSignUpResponse.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/08/02.
//

import Foundation

// MARK: - KakaoSignUpResponse
struct KakaoSignUpResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
}
