//
//  BoxOfficeViewController.swift
//  BoxOffice
//
//  Created by kjs on 13/01/23.
//

import UIKit
import OSLog

private enum Section: Hashable {
    case main
}

class BoxOfficeViewController: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Section, BoxOfficeData>! = nil
    private var collectionView: UICollectionView! = nil
    private var items = [BoxOfficeData]()
    private let yesterday = TargetDate(dayFromNow: -579)
    private let activityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = yesterday.formatByHyphen()
        configureHierarchy()
        configureDataSource()
        configureActivityIndicatorView()
        
        let networkManager = NetworkManager()
        
        networkManager.fetchData(url: KobisOpenAPI.boxOffice(targetDate: yesterday.formatNoSeparator()).url) { result in
            switch result {
            case .success(let data):
                do {
                    let decodedData = try DecodingManager.decodeJSON(type: BoxOffice.self, data: data)
                    print(decodedData)
                    
                    let boxOfficeItems = decodedData.boxOfficeResult.dailyBoxOfficeList
                    
                    boxOfficeItems.forEach { item in
                        self.items.append(item)
                    }
                    
                    var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeData>()
                    snapshot.appendSections([.main])
                    snapshot.appendItems(self.items)
                    self.dataSource.apply(snapshot, animatingDifferences: true)
                    self.stopActivityIndicator()
                } catch DataError.notFoundAsset {
                    os_log("%{public}@", type: .default, DataError.notFoundAsset.localizedDescription)
                } catch DataError.failedDecoding {
                    os_log("%{public}@", type: .default, DataError.failedDecoding.localizedDescription)
                } catch {
                    os_log("알 수 없는 오류입니다.", type: .default)
                }
            case .failure(let error):
                os_log("%{public}@", type: .default, error.localizedDescription)
            }
        }
    }
}

extension BoxOfficeViewController {
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        configureRefreshControl()
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BoxOfficeCell, BoxOfficeData> { (cell, indexPath, item) in
            let rankIntensityText = self.configureRankIntensity(with: item)
            cell.configureCell(with: item, rankIntensityText)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeData>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: BoxOfficeData) -> UICollectionViewListCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func configureRankIntensity(with boxOfficeData: BoxOfficeData) -> NSMutableAttributedString {
        let rankOldOrNew = boxOfficeData.rankOldOrNew
        guard let rankIntensity = Int(boxOfficeData.rankIntensity) else { return NSMutableAttributedString(string: "")}
        
        if rankOldOrNew == "OLD" {
            var text: String
            var attributedString: NSMutableAttributedString

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
            let text = "신작"
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(.foregroundColor, value: UIColor.systemRed, range: (text as NSString).range(of: "신작"))
            return attributedString
        }
    }
}

extension BoxOfficeViewController {
    private func configureActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .large
        activityIndicatorView.startAnimating()
    }
    
    private func stopActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
    
    private func configureRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.refreshControl?.endRefreshing()
        }
    }
}
