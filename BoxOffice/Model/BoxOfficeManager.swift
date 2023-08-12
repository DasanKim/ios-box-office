//
//  BoxOfficeManager.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/07.
//

import UIKit

final class BoxOfficeManager {
    func fetchBoxOfficeData(targetDate: TargetDate, completionHandler: @escaping (Result<[BoxOfficeData]?, Error>) -> Void) {
        let networkManager = NetworkManager()
        
        networkManager.fetchData(url: KobisAPI.boxOffice(targetDate: targetDate.formattedWithoutSeparator()).url) { (data, error) in
            do {
                if let error = error {
                    completionHandler(.failure(error))
                    
                    return
                }
                
                if let data = data {
                    let decodedData = try DecodingManager.decodeJSON(type: BoxOffice.self, data: data)
                    let boxOfficeItems = decodedData.boxOfficeResult.dailyBoxOfficeList
                    completionHandler(.success(boxOfficeItems))
                }
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchMovieData(movieCode: String, completionHandler: @escaping (Result<MovieInformation?, Error>) -> Void) {
        let networkManager = NetworkManager()
        
        networkManager.fetchData(url: KobisAPI.movie(movieCode: movieCode).url) { (data, error) in
            do {
                if let error = error {
                    completionHandler(.failure(error))
                    
                    return
                }
                
                if let data = data {
                    let decodedData = try DecodingManager.decodeJSON(type: Movie.self, data: data)
                    let movieInformation = decodedData.movieInformationResult.movieInformation
                    print(movieInformation)
                    completionHandler(.success(movieInformation))
                }
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
    
    func fetchMovieImageData(keyword: String, completionHandler: @escaping (Result<UIImage?, Error>) -> Void) {
        let networkManager = NetworkManager()
        var movieImageURLString: String?
        
        networkManager.fetchData(urlRequest: KakaoAPI.image(keyword: keyword).urlRequest) { (data, error) in
            do {
                if let error = error {
                    completionHandler(.failure(error))
                    return
                }
                
                if let data = data {
                    let decodedData = try DecodingManager.decodeJSON(type: MovieImage.self, data: data)
                    let movieImageItems = decodedData.documents
                    
                    movieImageURLString = movieImageItems.first?.imageURL
                }
                
                guard let movieImageURLString = movieImageURLString,
                      let movieImageURL = URL(string: movieImageURLString) else { return }
                
                networkManager.fetchImage(url: movieImageURL) { (image, error) in
                    if let error = error {
                        completionHandler(.failure(error))
                        return
                    }
                    
                    if let image = image {
                        completionHandler(.success(image))
                    }
                }
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}
