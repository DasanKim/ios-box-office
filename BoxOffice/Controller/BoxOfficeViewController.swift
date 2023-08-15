//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//  Last modified by Dasan & Whales.

import UIKit
import OSLog

private enum Section: Hashable {
    case main
}

final class BoxOfficeViewController: UIViewController {
    private let yesterday = TargetDate(dayFromNow: -1)
    private var items = [BoxOfficeData]()
    private var collectionView: UICollectionView! = nil
    private var dataSource: UICollectionViewDiffableDataSource<Section, BoxOfficeData>! = nil
    private let activityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureActivityIndicatorView()
        startActivityIndicator()
        loadData()
        configureDataSource()
        configureNavigationItem(title: yesterday.formattedWithHyphen())
        
        collectionView.delegate = self
    }
    
    private func loadData() {
        let boxOfficeManager = BoxOfficeManager()
        
        boxOfficeManager.fetchBoxOfficeData(targetDate: yesterday) { result in
            switch result {
            case .success(let items):
                guard let items = items else { return }
                self.items = items
                self.applySnapshot()
                self.stopActivityIndicator()
            case .failure(let error):
                os_log("%{public}@", type: .default, error.localizedDescription)
            }
        }
    }
}

extension BoxOfficeViewController {
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(collectionView)
        configureRefreshControl()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BoxOfficeCell, BoxOfficeData> { (cell, indexPath, item) in
            let rankIntensityText = self.configureRankIntensity(with: item)
            cell.updateLabel(with: item, rankIntensityText)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeData>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: BoxOfficeData) -> UICollectionViewListCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        applySnapshot()
    }
    
    private func configureRankIntensity(with boxOfficeData: BoxOfficeData) -> NSMutableAttributedString {
        var text: String
        var attributedString: NSMutableAttributedString
        let rankOldOrNew = boxOfficeData.rankOldOrNew
        
        guard let rankIntensity = Int(boxOfficeData.rankIntensity) else {
            return NSMutableAttributedString(string: "")
        }
        
        if rankOldOrNew == RankOldOrNew.old {
            if rankIntensity < 0 {
                text = "▼\(-rankIntensity)"
                attributedString = NSMutableAttributedString(string: text)
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: (text as NSString).range(of: "▼"))
                
                return attributedString
            } else if rankIntensity > 0 {
                text = "▲\(rankIntensity)"
                attributedString = NSMutableAttributedString(string: text)
                attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: (text as NSString).range(of: "▲"))
                
                return attributedString
            } else {
                return NSMutableAttributedString(string: "-")
            }
        } else {
            text = "신작"
            attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: (text as NSString).range(of: "신작"))
            
            return attributedString
        }
    }
    
    private func configureNavigationItem(title: String) {
        navigationItem.title = title
    }
}

extension BoxOfficeViewController {
    private func configureActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
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
    
    private func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.loadData()
            self.configureNavigationItem(title: self.yesterday.formattedWithHyphen())
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
}

extension BoxOfficeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieCode: String = items[indexPath.item].movieCode
        let movieInformationViewController = MovieInformationViewController(movieCode: movieCode)
        
        navigationController?.show(movieInformationViewController, sender: self)
    }
}
