//
//  StorageService.swift
//  HARA
//
//  Created by 김담인 on 2023/01/04.
//

import Foundation
import Moya

enum StorageService {
    case alone(param: Int)
    case with(param: Int)
}

extension StorageService: BaseTargetType {
    
    var path: String {
        switch self {
        case .alone(let param):
            return APIConstant.worryAloneList + "/\(param)"
            
        case .with(let param):
            return APIConstant.worryWithList + "/\(param)"
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
    
    var parameters: [String: Any]? {
        switch self {
        case .alone(let param):
            return ["ifsolved": param]
        
        case .with(let param):
            return ["ifsolved": param]
        }
    }
    
    var task: Task {
        switch self {
        case .alone(_):
///            return APIConstant.worryAloneList + "/\(param)"
            return .requestPlain
        
        case .with(_):
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
