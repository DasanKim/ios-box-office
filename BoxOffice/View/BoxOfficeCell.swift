//
//  BoxOfficeCell.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/05.
//

import UIKit

final class BoxOfficeCell: UICollectionViewListCell {
    static let identifier = "boxOfficeCell"
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        
        return label
    }()
    
    private let rankIntensityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        
        return label
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        
        return label
    }()
    
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        return stackView
    }()
    
    private var rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rankIntensityLabel.textColor = .black
    }
    
    func updateLabel(with boxOfficeData: BoxOfficeData, _ rankIntensityText: NSMutableAttributedString) {
        rankLabel.text = boxOfficeData.rank
        rankIntensityLabel.text = boxOfficeData.rankIntensity
        movieNameLabel.text = boxOfficeData.movieName
        
        guard let audienceCount = CountFormatter.decimal.string(for: Int(boxOfficeData.audienceCount)),
              let audienceAccumulate = CountFormatter.decimal.string(for: Int(boxOfficeData.audienceAccumulate))
        else { return }
        
        audienceLabel.text = "오늘 \(audienceCount) / 총 \(audienceAccumulate)"
        rankIntensityLabel.attributedText = rankIntensityText
    }
}

extension BoxOfficeCell {
    private func configureUI() {
        rankStackView.addArrangedSubview(rankLabel)
        rankStackView.addArrangedSubview(rankIntensityLabel)
        titleStackView.addArrangedSubview(movieNameLabel)
        titleStackView.addArrangedSubview(audienceLabel)
        stackView.addArrangedSubview(rankStackView)
        stackView.addArrangedSubview(titleStackView)
        
        contentView.addSubview(stackView)
        self.accessories = [.disclosureIndicator()]
        setUpStackViewConstraints()
    }
    
    private func setUpStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rankStackView.widthAnchor.constraint(
                equalTo: contentView.widthAnchor,
                multiplier: Constraints.rankStackViewFromContentViewWidth
            ),
            stackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            stackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: Constraints.stackViewFromContentViewTrailing
            ),
            stackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constraints.stackViewFromContentViewTop
            ),
            stackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: Constraints.stackViewFromContentViewBottom
            ),
            titleStackView.topAnchor.constraint(
                equalTo: stackView.topAnchor,
                constant: Constraints.titleViewFromContentViewTop
            ),
            titleStackView.bottomAnchor.constraint(
                equalTo: stackView.bottomAnchor,
                constant: Constraints.titleViewFromContentViewBottom
            )
        ])
    }
}
