//
//  MovieDetailStackView.swift
//  BoxOffice
//
//  Created by Dasan & Whales on 2023/08/15.
//

import UIKit

final class MovieDetailStackView: UIStackView {
    private var title: String?
    private var content: String?
    
    private let itemTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = .zero
        
        return label
    }()
    
    private let itemDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = .zero
        
        return label
    }()
    
    init(frame: CGRect, title: String, content: String) {
        super.init(frame: frame)
        self.title = title
        self.content = content
        
        configureUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLabels() {
        itemTitleLabel.text = title
        itemDescriptionLabel.text = content
    }
    
    private func configureUI() {
        self.axis = .horizontal
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 8
        self.translatesAutoresizingMaskIntoConstraints = false
        
        configureLabels()
        
        self.addArrangedSubview(itemTitleLabel)
        self.addArrangedSubview(itemDescriptionLabel)
        
        NSLayoutConstraint.activate([
            itemTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15)
        ])
    }
}
