class NewsViewModel {
    // MARK: - Properties
    private let newsFetcher: NewsFetcherProtocol
    private(set) var news: [News] = []
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?

    // MARK: - Initializer
    init(newsFetcher: NewsFetcherProtocol = NewsFetcher()) {
        self.newsFetcher = newsFetcher
    }

    // MARK: - Public Methods
    /// Fetches news articles from the service
    func fetchNews(for query: APIConstants.Query = .apple) {
        newsFetcher.fetchNews(for: query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                self.handleSuccess(articles)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }

    /// Returns a news item at the specified index
    func news(at index: Int) -> News? {
        guard index >= 0 && index < news.count else { return nil }
        return news[index]
    }

    // MARK: - Private Methods
    /// Handles successful fetching of news
    private func handleSuccess(_ articles: [News]) {
        self.news = articles
        self.onUpdate?()
    }

    /// Handles errors during fetching of news
    private func handleError(_ error: Error) {
        print("Error fetching news: \(error.localizedDescription)")
        onError?("Failed to fetch news. Please try again later.")
    }
}
