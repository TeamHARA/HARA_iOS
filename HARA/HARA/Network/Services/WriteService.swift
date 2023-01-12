//
//  WriteService.swift
//  HARA
//
//  Created by 배성호 on 2023/01/04.
//

import Foundation
import Moya

enum WriteService {
    case alone(param: WriteRequest)
    case with(param: WriteRequest)
}

extension WriteService: BaseTargetType {
    
    var path: String {
        switch self {
        case .alone:
            return APIConstant.worryAlone
        case .with:
            return APIConstant.worryWith
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .alone, .with:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .alone(let param):
//            let jsonEncoder = JSONEncoder()
//            let jsonData = try jsonEncoder.encode(sentence)
            return .requestJSONEncodable(param)
//            return .requestPlain
        case .with(let param):
            return .requestJSONEncodable(param)
        }
    }

    var headers: [String : String]? {
        switch self {
        case .alone, .with:
            return NetworkConstant.noTokenHeader
        }
    }
}
