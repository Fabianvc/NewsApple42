import UIKit

class NewsListDataSource: UICollectionViewDiffableDataSource<Int, News> {
    // MARK: - Initializer
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) { (collectionView, indexPath, news) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewsListConstants.Cells.newsCellIdentifier,
                for: indexPath
            ) as! NewsCell
            cell.configure(with: news)
            return cell
        }
    }

    // MARK: - Snapshot Management
    func applySnapshot(news: [News], animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, News>()
        snapshot.appendSections([.zero])
        snapshot.appendItems(news, toSection: .zero)
        apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
