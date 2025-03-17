protocol NewsFetcherProtocol {
    func fetchNews(for query: APIConstants.Query, completion: @escaping (Result<[News], Error>) -> Void)
}
