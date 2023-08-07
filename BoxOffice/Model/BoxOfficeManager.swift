//
//  BoxOfficeManager.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/07.
//

final class BoxOfficeManager {
    private let targetDate: TargetDate
    
    init(targetDate: TargetDate) {
        self.targetDate = targetDate
    }
    
    func fetchBoxOfficeData(completionHandler: @escaping (Result<[BoxOfficeData]?, Error>) -> Void) {
        let networkManager = NetworkManager()
        
        networkManager.fetchData(url: KobisOpenAPI.boxOffice(targetDate: targetDate.formatNoSeparator()).url) { (data, error) in
            do {
                if let data = data {
                    let decodedData = try DecodingManager.decodeJSON(type: BoxOffice.self, data: data)
                    print(decodedData)
                    let boxOfficeItems = decodedData.boxOfficeResult.dailyBoxOfficeList
                    completionHandler(.success(boxOfficeItems))
                } else if let error = error {
                    completionHandler(.failure(error))
                }
            } catch {
                completionHandler(.failure(error))
            }
        }
    }
}
