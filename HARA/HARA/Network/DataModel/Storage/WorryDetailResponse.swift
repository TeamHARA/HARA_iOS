//
//  AloneWorryDetailResponse.swift
//  HARA
//
//  Created by saint on 2023/01/13.
//

import Foundation

// MARK: - WorryAloneDetailResponse
struct WorryAloneDetailResponse: Codable {
    var finalOption: Int?
    var createdAt, worryTitle, worryContent: String
    var category: String
    var options: Option
    
    // MARK: - Option
    struct Option: Codable {
        var id, worryAloneId: Int
        var title: String
        var advantage, disadvantage: String?
        var image: String?
        var hasImage: Bool
    }
}

// MARK: - WorryWithDetailResponse
struct WorryWithDetailResponse: Codable {
    var isAuthor: Bool
    var finalOption: Int?
    var isVoted: Bool
    var selectedOptionId: Int?
    var createdAt, worryTitle, worryContent, category: String
    var options: [Option]
    var commentCount: Int
    var comments: [Comment]?
    
    // MARK: - Option
    struct Option: Codable {
        var id, worryWithId: Int
        var title: String
        var advantage, disadvantage: String?
        var image: String?
        var hasImage: Bool
        var percentage: Int?
    }
    
    // MARK: - Comment
    struct Comment: Codable {
        var userNickName: String
        var userImage: String
        var content: String
        var createdAt: String
    }
}



