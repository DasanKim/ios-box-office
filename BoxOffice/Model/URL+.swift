//
//  URL+.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/28.
//

import Foundation

extension URL {
    init?(_ baseURL: String, _ path: String, _ query: [URLQueryItem]) {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        urlComponents?.queryItems = query

        guard let url = urlComponents?.url else {
            return nil
        }

        self = url
    }
}
