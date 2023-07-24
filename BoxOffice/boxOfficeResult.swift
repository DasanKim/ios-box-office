//
//  boxOfficeResult.swift
//  BoxOffice
//
//  Created by Whales on 2023/07/25.
//

//import Foundation

struct boxOfficeResult: Codable { // 파일 주고받고 하려고
    var boxOfficeType: String
    var showRange: String
    var dailyBoxOfficeList: [String]
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}
