//
//  DailyBoxOfficeItem.swift
//  BoxOffice
//
//  Created by Whales on 2023/07/25.
//

struct DailyBoxOfficeItem: Decodable { // daily면 바뀌지 않을까?
    var rawNumber: String
    var rank: String
    var rankInten: String // 얘는 뭘까? Integer 느낌이었는데 n이란 말이지. 증감분이래 근데 무슨 영어가 있지
    var rankOldAndNew: String
    var movieCode: String // movieCode?
    var movieName: String
    var openDate: String
    var salesAmount: String
    var salesShare: String
    var salesInten: String
    var salesChange: String
    var salesAccumulation: String // Acc는 악세사리 생각 밖에 안나는데
    var audienceCount: String // audience가 청중, 관객
    var audienceInten: String
    var audienceChange: String
    var audienceAccumulation: String
    var screenCount: String
    var showCount: String
    
    private enum CodingKeys: String, CodingKey {
        case rawNumber = "rnum"
        case rank
        case rankInten = "rankInten"
        case rankOldAndNew
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case openDate = "openDt"
        case salesAmount = "salesAmt"
        case salesShare
        case salesInten = "salesInten"
        case salesChange
        case salesAccumulation = "salesAcc"
        case audienceCount = "audiCnt"
        case audienceInten = "audiInten"
        case audienceChange = "audiChange"
        case audienceAccumulation = "audiAcc"
        case screenCount = "scrnCnt"
        case showCount = "showCnt"
    }
}
