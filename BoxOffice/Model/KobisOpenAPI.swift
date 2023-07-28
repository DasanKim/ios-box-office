//
//  KobisOpenAPI.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/28.
//

import Foundation

enum KobisOpenAPI {
    case boxOffice(String)
    case movie(String)
}

extension KobisOpenAPI: API {
    var baseURL: String {
        return "http://www.kobis.or.kr"
    }
    
    var path: String {
        switch self {
        case .boxOffice:
            return "/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        case .movie:
            return "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
        }
    }
    
    var query: [URLQueryItem] {
        switch self {
        case .boxOffice(let targetDate):
            return [URLQueryItem(name: "key", value: key),
                    URLQueryItem(name: "targetDt", value: targetDate)]
        case .movie(let movieCode):
            return [URLQueryItem(name: "key", value: key),
                    URLQueryItem(name: "movieCd", value: movieCode)]
        }
    }
    
    var key: String {
        return "fb92260b76d9959bbf3ab69c991d8985"
    }
    
    var url: URL? {
        return URL(baseURL, path, query)
    }
}
