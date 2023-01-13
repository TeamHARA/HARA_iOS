//
//  WriteRequest.swift
//  HARA
//
//  Created by saint on 2023/01/12.
//

import Foundation

// MARK: - Welcome
struct WriteRequest: Codable {
    var title, content: String
    var categoryId: Int
    var options: [Option]
    
    // MARK: - Option
    struct Option: Codable {
        var title: String
        var advantage, disadvantage, image: String?
        var hasImage: Bool
    }
}
