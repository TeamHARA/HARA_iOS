//
//  WorryDetailService.swift
//  HARA
//
//  Created by saint on 2023/01/13.
//

import Foundation
import Moya

enum WorryDetailService {
    case alone(param: Int)
    case with(param: Int)
}

extension WorryDetailService: BaseTargetType {
    
    var path: String {
        switch self {
        case .alone(let param):
            return APIConstant.worryAloneDetail + "/\(param)"
            /// param은 int형으로 받아온다.
            
        case .with(let param):
            return APIConstant.worryWithDetail + "/\(param)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .alone:
            return .get
            
        case .with:
            return .get
        }
    }

//    var parameters: [String: Any]? {
//        switch self {
//        case .alone(let param):
//            return ["worryId": param]
//
//        case .with(let param):
//            return ["worryId": param]
//        }
//    }
    
    var task: Task {
        switch self {
        case .alone:
            return .requestPlain
        
        case .with:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        case .alone:
            return NetworkConstant.noTokenHeader
        
        case .with:
            return NetworkConstant.noTokenHeader
        }
    }
}

