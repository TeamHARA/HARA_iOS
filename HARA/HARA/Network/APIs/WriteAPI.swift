//
//  GenericResponse.swift
//  HARA
//
//  Created by 김담인 on 2022/12/27.
//

import Foundation
import Moya

final class WriteAPI {
    
    static let shared: WriteAPI = WriteAPI()
    private let writeProvider = MoyaProvider<WriteService>(plugins: [MoyaLoggingPlugin()])
    private init() { }
    
    public private(set) var writeAloneResponse: VoidType?
    public private(set) var writeWithResponse: VoidType?
//    public private(set) var loginRequest: LoginRequest?
    
    // MARK: - PostAloneFunction
    func postWriteAloneList(param: WriteRequest, completion: @escaping ((VoidType?) -> ())) {
        writeProvider.request(.alone(param: param)) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    print("성공")
                    print(result)
                    self?.writeAloneResponse = try result.map(VoidType?.self)
//                    print(self?.storageAloneResponse as Any)
                    print("123\(self?.writeAloneResponse)")
                    guard let aloneData = self?.writeAloneResponse else {
                        print("??")
                        return
                    }
                    
                    completion(aloneData)
                } catch(let err) {
                    print("실패")
                    print(err.localizedDescription)
                    completion(nil)
                }
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
    }
    
    // MARK: - PostWithFunction
    func postWriteWithList(param: WriteRequest, completion: @escaping ((VoidType?) -> ())) {
        writeProvider.request(.with(param: param)) { [weak self] response in
            switch response {
            case .success(let result):
                do {
                    print("성공")
                    print(result)
                    self?.writeWithResponse = try result.map(VoidType?.self)
//                    print(self?.storageAloneResponse as Any)
                    print("123\(self?.writeWithResponse)")
                    guard let withData = self?.writeWithResponse else {
                        print("??")
                        return
                    }
                    completion(withData)
                } catch(let err) {
                    print("실패")
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
