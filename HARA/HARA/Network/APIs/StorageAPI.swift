//
//  NetworkConstants.swift
//  HARA
//
//  Created by 김담인 on 2022/12/27.
//

import Foundation
import Moya

final class StorageAPI {
    
    static let shared: StorageAPI = StorageAPI()
    private let storageProvider = MoyaProvider<StorageService>(plugins: [MoyaLoggingPlugin()])
    private init() { }
    
    public private(set) var storageAloneResponse: GeneralArrayResponse<StorageResponse>?
    
    public private(set) var storageWithResponse: GeneralArrayResponse<StorageResponse>?
    
    // MARK: - StorageAlone
    func getStorageAloneList(param123: Int, completion: @escaping ((GeneralArrayResponse<StorageResponse>?) -> ())) {
        storageProvider.request(.alone(param: param123)) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    print(result)
                    self?.storageAloneResponse = try result.map(GeneralArrayResponse<StorageResponse>?.self)
                    guard let aloneData = self?.storageAloneResponse else {
                        return
                    }
                    completion(aloneData)
                } catch(let err) {
                    print(err.localizedDescription)
                    completion(nil)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    // MARK: - StorageWith
    func getStorageWithList(param11: Int, completion: @escaping ((GeneralArrayResponse<StorageResponse>?) -> ())) {
        storageProvider.request(.with(param: param11)) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    self?.storageWithResponse = try result.map(GeneralArrayResponse<StorageResponse>?.self)
                    guard let withData = self?.storageWithResponse else {
                        return
                    }
                    completion(withData)
                } catch(let err) {
                    print(err.localizedDescription)
                    completion(nil)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
}
