@testable import NewsApple

class MockNewsService: NewsServiceProtocol {
    // MARK: - Properties
    /// Indica si el servicio debe devolver un error
    var shouldReturnError: Bool = false

    /// Error que se devolverá si `shouldReturnError` es `true`
    var errorToReturn: Error = ServiceError.invalidResponse

    /// Respuesta simulada que se devolverá si `shouldReturnError` es `false`
    var mockResponse: NewsResponse?

    // MARK: - Initializer
    init(shouldReturnError: Bool = false, errorToReturn: Error = ServiceError.invalidResponse, mockResponse: NewsResponse? = nil) {
        self.shouldReturnError = shouldReturnError
        self.errorToReturn = errorToReturn
        self.mockResponse = mockResponse
    }

    // MARK: - Methods
    func performRequest<T: Decodable>(
        endpoint: String,
        httpMethod: APIConstants.HttpMethod,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        if shouldReturnError {
            completion(.failure(errorToReturn))
        } else if let response = mockResponse as? T {
            completion(.success(response))
        } else {
            completion(.failure(ServiceError.decodingError))
        }
    }
}
