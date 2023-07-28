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
        networkManager.fetchData(url: "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
                                 queryItems: [URLQueryItem(name: "key", value: "7d6424cd4dd7dcd54101af0351f3946e"),
                                              URLQueryItem(name: "targetDt", value: "20220102")]) { data in
            guard let decodedData: BoxOffice = try? DecodingManager.decodeJSON(data: data) else {
                return
            }
            print(decodedData)
        }
        
        networkManager.fetchData(url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json",
                                 queryItems: [URLQueryItem(name: "key", value: "fb92260b76d9959bbf3ab69c991d8985"),
                                              URLQueryItem(name: "movieCd", value: "20124079")]) { data in
            guard let decodedData: Movie = try? DecodingManager.decodeJSON(data: data) else {
                return
            }
            print(decodedData)
        }
    }


}

