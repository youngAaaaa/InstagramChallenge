//
//  SignUpResponse.swift
//  InstagramChallenge
//
//  Created by 안다영 on 2022/07/29.
//
import Foundation

// MARK: - SignUpResponse
struct SignUpResponse: Decodable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result?
}
