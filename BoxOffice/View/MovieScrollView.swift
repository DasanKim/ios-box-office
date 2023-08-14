//
//  MovieScrollView.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/14.
//

import UIKit

final class MovieScrollView: UIScrollView {
    private var image: UIImage = UIImage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        self.image = image
        
        configureUI()
    }
    
    private let movieStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        
        return stackView
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        return imageView
    }()
    
    private func configureUI() {
        movieImageView.image = image
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(movieStackView)
        movieStackView.addArrangedSubview(movieImageView)
        
        NSLayoutConstraint.activate([
            movieStackView.topAnchor.constraint(equalTo: self.topAnchor),
            movieStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            movieStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            movieStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            movieImageView.widthAnchor.constraint(equalTo: movieStackView.widthAnchor),
            movieImageView.heightAnchor.constraint(lessThanOrEqualTo: self.frameLayoutGuide.heightAnchor, multiplier: 0.6)
        ])
    }
}
