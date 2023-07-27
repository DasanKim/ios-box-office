//
//  Movie.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/27.
//

struct Movie: Decodable {
    let movieInformationResult: MovieInformationResult
    
    private enum CodingKeys: String, CodingKey {
        case movieInformationResult = "movieInfoResult"
    }
}
