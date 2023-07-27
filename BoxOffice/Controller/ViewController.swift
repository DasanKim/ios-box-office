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
                                              URLQueryItem(name: "targetDt", value: "20220102")])
    }


}

