//
//  StorageAloneResponse.swift
//  HARA
//
//  Created by 누리링 on 2023/01/12.
//

import Foundation

// MARK: - StorageResponse
struct StorageResponse: Codable {
    var id, categoryId: Int
    let title : String?
    var createdAt: String
    var finalOption: Int?
}


