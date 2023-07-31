//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/27.
//

import Foundation

struct NetworkManager {
    func fetchData(url: URL?, completionHandler: @escaping (Data) -> ()) {
        guard let url = url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            completionHandler(data)
        }
        
        task.resume()
    }
}
