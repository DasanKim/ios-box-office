//
//  ViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkManager = NetworkManager()
        networkManager.fetchData(url: KobisOpenAPI.boxOffice("20220102").url) { data in
            guard let decodedData: BoxOffice = try? DecodingManager.decodeJSON(data: data) else {
                return
            }
            print(decodedData)
        }

        networkManager.fetchData(url: KobisOpenAPI.movie("20124079").url) { data in
            guard let decodedData: Movie = try? DecodingManager.decodeJSON(data: data) else {
                return
            }
            print(decodedData)
        }
    }
}


protocol API {
    var baseURL: String { get }
    var path: String { get }
    var query: [URLQueryItem] { get }
    var key: String { get }
}

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
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        urlComponents?.queryItems = query

        return urlComponents?.url
    }
}
