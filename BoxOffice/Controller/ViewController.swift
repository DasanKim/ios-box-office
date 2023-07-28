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
        
        networkManager.fetchData(url: KobisOpenAPI.boxOffice(targetDate: "20220102").url) { data in
            guard let decodedData = try? DecodingManager.decodeJSON(type: BoxOffice.self, data: data) else {
                return
            }
            print(decodedData)
        }

        networkManager.fetchData(url: KobisOpenAPI.movie(movieCode: "20124079").url) { data in
            guard let decodedData = try? DecodingManager.decodeJSON(type: Movie.self, data: data) else {
                return
            }
            print(decodedData)
        }
    }
}
