//
//  APIConstant.swift
//  HARA
//
//  Created by 김담인 on 2023/01/04.
//

import Foundation

struct APIConstant {
    
    //MARK: - Base
    static let baseURL = "http://3.37.47.67:3000"
    
    //MARK: - Together
    //TODO: 카테고리별 분기 처리
    static let worryVote = "worry"

    static let worryCategory = "worry"
    
    static let worryFinalAlone = "worry/worryAlone"
    
    static let worryFinalWith = "worry/with"
    
    /// 파라미터 :worryId
    static let worryAloneDetail = "/worry/alone"

    static let worryWidthDetail = "worry/with"
    
    //MARK: - Write
    static let worryAlone = "worry/alone"
    
    static let worryWith = "worry/with"
    
    // MARK: - Storage
    
    /// 목록조회 파라미터 :ifSolved
    static let worryWithList = "worry/with/list"
    
    static let worryAloneList = "worry/alone/list"
    
    static let random = "random"
    
    /// 후순위
    /// 쿼리
    static let worrySearchList = "worry"
    /// 일단 클라처리
    static let myPastWorry = "random/list"
    
    
}
