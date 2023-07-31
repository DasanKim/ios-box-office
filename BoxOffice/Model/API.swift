//
//  API.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/28.
//

import Foundation

protocol API {
    var baseURL: String { get }
    var path: String { get }
    var queries: [URLQueryItem] { get }
}
