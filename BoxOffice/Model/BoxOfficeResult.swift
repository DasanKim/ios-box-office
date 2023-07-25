//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by Whales on 2023/07/25.
//

//import Foundation

struct BoxOfficeResult: Decodable { // 파일 받기만
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeItem]
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case dailyBoxOfficeList
    }
}
