//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/27.
//

import UIKit

struct NetworkManager {
    func fetchData(url: URL?, completionHandler: @escaping ((Data?, NetworkError?)) -> Void) {
        guard let url = url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completionHandler((nil, NetworkError.requestFailed))

                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler((nil, NetworkError.invalidResponse))
                
                return
            }
            
            guard let data = data else {
                completionHandler((nil, NetworkError.noData))
                
                return
            }
            
            completionHandler((data, nil))
        }
        
        task.resume()
    }
    
    func fetchData(urlRequest: URLRequest?, completionHandler: @escaping ((Data?, NetworkError?)) -> Void) {
        guard let urlRequest = urlRequest else { return }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completionHandler((nil, NetworkError.requestFailed))

                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler((nil, NetworkError.invalidResponse))
                
                return
            }
            
            guard let data = data else {
                completionHandler((nil, NetworkError.noData))
                
                return
            }
            
            completionHandler((data, nil))
        }
        
        task.resume()
    }
    
    func fetchImage(url: URL?, completionHandler: @escaping ((UIImage?, NetworkError?)) -> Void) {
        guard let url = url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completionHandler((nil, NetworkError.requestFailed))

                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completionHandler((nil, NetworkError.invalidResponse))
                
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completionHandler((nil, NetworkError.noData))
                
                return
            }
            
            completionHandler((image, nil))
        }
        
        task.resume()
    }
}
