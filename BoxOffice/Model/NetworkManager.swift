//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/27.
//

import Foundation

struct NetworkManager {
    private func configureURL(url: String, queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(string: url) else {
            return nil
        }

        urlComponents.queryItems = queryItems
    
        return urlComponents.url
    }
    
    func fetchData(url: String, queryItems: [URLQueryItem], completionHandler: @escaping (Data) -> ()) {
        guard let url = configureURL(url: url, queryItems: queryItems) else {
            return
        }
        
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
