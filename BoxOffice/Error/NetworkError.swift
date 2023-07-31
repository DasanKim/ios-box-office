//
//  NetworkError.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/31.
//

import Foundation

enum NetworkError: LocalizedError {
    case requestFailed
    case invalidResponse(URLResponse)
    case noData
    
    var errorDescription: String? { // 옵셔널. 그래야 원래 있던 걸 씀. 아니면 새로운 친구로 덮어씌워짐
        switch self {
        case .requestFailed:
            return "요청이 실패하였습니다."
        case .invalidResponse(let response):
            return "HTTP 요청코드: \(response)"
        case .noData:
            return "데이터가 없습니다."
        }
    }
}
