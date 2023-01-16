//
//  WorryDetailAPI.swift
//  HARA
//
//  Created by saint on 2023/01/13.
//

import Foundation
import Moya

final class WorryDetailAPI {
    
    static let shared: WorryDetailAPI = WorryDetailAPI()
    private let worryDetailProvider = MoyaProvider<WorryDetailService>(plugins: [MoyaLoggingPlugin()])
    private init() { }
    
    public private(set) var worryAloneDetailResponse: GeneralArrayResponse<WorryAloneDetailResponse>?
    
    public private(set) var worryWithDetailResponse: GeneralArrayResponse<WorryWithDetailResponse>?
    
    // MARK: - WorryAlone
    func getWorryAloneList(param: Int, completion: @escaping ((GeneralArrayResponse<WorryAloneDetailResponse>?) -> ())) {
        worryDetailProvider.request(.alone(param: param)) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    self?.worryAloneDetailResponse = try
                    result.map(GeneralArrayResponse<WorryAloneDetailResponse>?.self)
                    print("성공")
                    print(result)
                    guard let aloneData = self?.worryAloneDetailResponse else { print("빠짐")
                        return
                    }
                    print(aloneData)
                    completion(aloneData)
                } catch(let err) {
                    print("데이터 실패")
                    print(err.localizedDescription)
                    completion(nil)
                }
            case .failure(let err):
                print("실패")
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    // MARK: - StorageWith
    func getWorryWithList(param: Int, completion: @escaping ((GeneralArrayResponse<WorryWithDetailResponse>?) -> ())) {
        worryDetailProvider.request(.with(param: param)) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    self?.worryWithDetailResponse = try result.map(GeneralArrayResponse<WorryWithDetailResponse>?.self)
                    print("성공")
                    guard let withData = self?.worryWithDetailResponse else {print("2")
                        return
                    }
                    print(withData)
                    completion(withData)
                } catch(let err) {
                    print("데이터 실패")
                    print(err.localizedDescription)
                    completion(nil)
                }
            case .failure(let err):
                print("실패")
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
