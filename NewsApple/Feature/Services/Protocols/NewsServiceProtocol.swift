protocol NewsServiceProtocol {
    func performRequest<T: Decodable>(
        endpoint: String,
        httpMethod: APIConstants.HttpMethod,
        completion: @escaping (Result<T, Error>) -> Void
    )
}
