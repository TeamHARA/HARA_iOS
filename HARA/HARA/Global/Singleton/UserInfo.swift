//
//  UserInfo.swift
//  HARA
//
//  Created by 김담인 on 2022/12/27.
//
import UIKit

class UserInfo {
    static let shared = UserInfo()
    
    private init() { }
    
    var userId: String?
}
