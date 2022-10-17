//
//  SignInRequest.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/29.
//
import Foundation

// MARK: - SignInRequest
struct SignInRequest: Encodable {
    let loginId, password: String
}
