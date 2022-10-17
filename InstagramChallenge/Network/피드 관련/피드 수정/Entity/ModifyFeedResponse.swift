//
//  ModifyFeedResponse.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/07.
//

import Foundation

// MARK: - ModifyFeedResponse
struct ModifyFeedResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
