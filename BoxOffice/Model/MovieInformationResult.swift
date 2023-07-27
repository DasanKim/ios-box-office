//
//  MovieInformationResult.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/07/27.
//

struct MovieInformationResult: Decodable {
    let movieInformation: MovieInformation
    let source: String
    
    private enum CodingKeys: String, CodingKey {
        case movieInformation = "movieInfo"
        case source
    }
}
