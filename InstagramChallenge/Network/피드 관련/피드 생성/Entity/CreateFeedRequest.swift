//
//  CreateFeedRequest.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/06.
//

import Foundation

// MARK: - CreateFeedRequest
struct CreateFeedRequest: Codable {
    let feedText: String
    let contentsUrls: [String]
}
