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
    private var items: [BoxOfficeData] = [BoxOfficeData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
        
        let networkManager = NetworkManager()
        
        networkManager.fetchData(url: KobisOpenAPI.boxOffice(targetDate: "20220102").url) { result in
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
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BoxOfficeCell, BoxOfficeData> { (cell, indexPath, item) in
            cell.configureCell(with: item)
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
}
