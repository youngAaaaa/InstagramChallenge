//
//  SignInResponse.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/29.
//

import Foundation

// MARK: - SignInResponse
struct SignInResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
}

// MARK: - Result
struct Result: Codable {
    let jwt: String?
    let loginId: String?
}
