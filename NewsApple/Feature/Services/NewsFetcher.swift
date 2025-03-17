class NewsFetcher: NewsFetcherProtocol {
    private let service: NewsServiceProtocol

    // MARK: - Initializer
    init(service: NewsServiceProtocol = NewsService()) {
        self.service = service
    }

    // MARK: - Public Methods
    func fetchNews(for query: APIConstants.Query, completion: @escaping (Result<[News], Error>) -> Void) {
        let endpoint = APIConstants.endpoint(for: query)
        service.performRequest(endpoint: endpoint, httpMethod: .get) { (result: Result<NewsResponse, Error>) in
            switch result {
            case .success(let newsResponse):
                completion(.success(newsResponse.articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
