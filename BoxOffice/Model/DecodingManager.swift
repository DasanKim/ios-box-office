//
//  DecodingManager.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/25.
//

import UIKit

struct DecodingManager {
    func decodeJSON<T: Decodable>(fileName: String) throws -> T {
        let decoder = JSONDecoder()
        
        guard let dataAsset: NSDataAsset = NSDataAsset(name: fileName) else {
            throw DataError.notFoundAsset
        }
        guard let decodedData: T = try? decoder.decode(T.self, from: dataAsset.data) else {
            throw DataError.failedDecoding
        }
        
        return decodedData
    }
}
