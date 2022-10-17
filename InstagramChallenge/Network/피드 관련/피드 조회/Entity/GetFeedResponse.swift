//
//  GetFeedResponse.swift
//  InstagraChallenge
//
//  Created by 안다영 on 2022/08/06.
//

import Foundation

// MARK: - CreateFeedResponse
struct GetFeedResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [FeedResult]
}

// MARK: - Result
struct FeedResult: Codable {
    let feedId: Int
    let feedLoginId, feedText, feedCreatedAt, feedUpdatedAt: String
    let feedCommentCount: Int
    let contentsList: [ContentsList]
}


// MARK: - ContentsList
struct ContentsList: Codable {
    let contentsId: Int
    let contentsUrl: String
    let createdAt, updatedAt: String
}
