//
//  DecodingManager.swift
//  BoxOffice
//
//  Created by Whales on 2023/07/25.
//

//import UIKit
//
//final class DecodingManager { // 싱글톤
//    static let shared = DecodingManager()
//
//    private init() {} // 다른 인스턴스가 안 생기도록 init을 은닉화
//
//    func decodeJSON<T: Decodable>(fileName: String, type: T.Type) throws -> T {
//        let decoder = JSONDecoder()
//
//        guard let dataAsset: NSDataAsset = NSDataAsset(name: fileName),
//              let decodedData: T = try? decoder.decode(T.self, from: dataAsset.data)
//        else {
//            throw DecodingError.failedDecoding
//        }
//
//        return decodedData
//    }
//}

/*
싱글톤을 쓰면
main에서 안쓰고 Test에서만 쓰면 문제가 된다.
 
real vs test 분리 안된다.


*/
