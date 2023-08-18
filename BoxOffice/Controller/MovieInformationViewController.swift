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
    private var movieCode: String?
    
    private var posterImage: UIImage?
    private let activityIndicatorView = UIActivityIndicatorView()
    
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
        
        configureActivityIndicatorView()
        startActivityIndicator()
        loadData()
    }
    
    private func loadData() {
        guard let movieCode = movieCode else { return }
        
        boxOfficeManager.fetchMovieData(movieCode: movieCode) { result in
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
                    self.stopActivityIndicator()
                    self.configureUI()
                }
            case .failure(let error):
                os_log("%{public}@", type: .default, error.localizedDescription)
            }
        }
    }
}

extension MovieInformationViewController {
    private func configureNavigationItem(title: String?) {
        navigationItem.title = title
    }
    
    private func configureUI() {
        guard let posterImage = posterImage,
              let movieInformation = movieInformation else { return }
        
        let movieScrollView = MovieScrollView(frame: .zero, image: posterImage, movieInformation: movieInformation)
        
        activityIndicatorView.removeFromSuperview()
        view.addSubview(movieScrollView)
        
        NSLayoutConstraint.activate([
            movieScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            movieScrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            movieScrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            movieScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MovieInformationViewController {
    private func configureActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.style = .large
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func startActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicatorView.startAnimating()
        }
    }
    
    private func stopActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
        }
    }
}
