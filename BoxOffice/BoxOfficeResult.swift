//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Whales on 2023/07/25.
//

//import Foundation

struct BoxOfficeResult: Codable { // 파일 주고받고 하려고
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeItem]
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}
