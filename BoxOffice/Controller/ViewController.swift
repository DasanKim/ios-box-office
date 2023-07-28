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
