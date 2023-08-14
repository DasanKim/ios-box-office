//
//  MovieInformationViewController.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/14.
//

import UIKit
import OSLog

final class MovieInformationViewController: UIViewController {
    private let boxOfficeManager = BoxOfficeManager()
    private var movieInformation: MovieInformation?
    private var movieCode = String()
    private var posterImage: UIImage?
    
    init(movieCode: String) {
        super.init(nibName: nil, bundle: nil)
        self.movieCode = movieCode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        loadData()
    }
    
    private func loadData() {
        boxOfficeManager.fetchMovieData(movieCode: movieCode){ result in
            switch result {
            case .success(let movieInformation):
                DispatchQueue.main.async {
                    self.movieInformation = movieInformation
                    self.configureNavigationItem(title: movieInformation?.movieName)
                    self.loadPosterImage()
                }
            case .failure(let error):
                os_log("%{public}@", type: .default, error.localizedDescription)
            }
        }
    }
    
    private func loadPosterImage() {
        let movieName = movieInformation?.movieName ?? ""
        let keyword = movieName + " 영화 포스터"
        
        boxOfficeManager.fetchMovieImageData(keyword: keyword) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.posterImage = image
                    self.configureUI()
                }
                self.posterImage = image
            case .failure(let error):
                os_log("%{public}@", type: .default, error.localizedDescription)
            }
        }
    }
    
    private func configureNavigationItem(title: String?) {
        navigationItem.title = title
    }
    
    private func configureUI() {
        guard let posterImage = posterImage else { return }
        let movieScrollView = MovieScrollView(frame: view.frame, image: posterImage)
        
        view.addSubview(movieScrollView)
        
        NSLayoutConstraint.activate([
            movieScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            movieScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
