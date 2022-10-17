//
//  SignUpRequest.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/29.
//

import Foundation

// MARK: - SignUpRequest
struct SignUpRequest: Encodable {
    let realName: String
    let password: String
    let loginId: String
    let birthDate: String
    let phoneNumber: String
}
