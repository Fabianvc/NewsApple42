import UIKit

class NewsListDelegate: NSObject, UICollectionViewDelegate {
    // MARK: - Properties
    private let dataSource: NewsListDataSource
    private let onSelectNews: (News) -> Void

    // MARK: - Initializer
    init(dataSource: NewsListDataSource, onSelectNews: @escaping (News) -> Void) {
        self.dataSource = dataSource
        self.onSelectNews = onSelectNews
    }

    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let news = dataSource.itemIdentifier(for: indexPath) else { return }
        onSelectNews(news)
    }
}
