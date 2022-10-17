//
//  CreateFeedResponse.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/06.
//

import Foundation

// MARK: - CreateFeedResponse
struct CreateFeedResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
}
