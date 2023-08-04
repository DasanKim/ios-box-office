//
//  BoxOfficeCell.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/05.
//

import UIKit

final class BoxOfficeCell: UICollectionViewListCell {
    static let Identifier = "boxOfficeCell"
    private var stackView = UIStackView()
    private var rankStackView = UIStackView()
    private var titleStackView = UIStackView()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        return label
    }()
    
    private let rankIntensityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        return label
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .left
        return label
    }()
    
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        return label
    }()
    
    private func configureLabel(with boxOfficeData: BoxOfficeData) {
        rankLabel.text = boxOfficeData.rank
        rankIntensityLabel.text = boxOfficeData.rankIntensity
        movieNameLabel.text = boxOfficeData.movieName
        audienceLabel.text = "오늘 \(boxOfficeData.audienceCount) / 총 \(boxOfficeData.audienceAccumulate)"
    }
        
    func configureCell(with boxOfficeData: BoxOfficeData) {
        configureLabel(with: boxOfficeData)
        
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankIntensityLabel)
        titleStackView.addArrangedSubview(movieNameLabel)
        titleStackView.addArrangedSubview(audienceLabel)
        stackView.addArrangedSubview(rankStackView)
        stackView.addArrangedSubview(titleStackView)
        
        rankStackView.axis = .vertical
        titleStackView.axis = .vertical
        stackView.axis = .horizontal
        
        self.addSubview(stackView)
        self.accessories = [.disclosureIndicator()]
        setUpStackViewConstraints()
    }
}

extension BoxOfficeCell {
    private func setUpStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rankStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15)
        ])
    }
}
