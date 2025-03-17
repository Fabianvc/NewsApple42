class NewsService: NewsServiceProtocol {
    // MARK: - Properties
    private let session: URLSession
    
    // MARK: - Initializer
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    // MARK: - Public Methods
    /// Performs a generic HTTP request
    func performRequest<T: Decodable>(
        endpoint: String,
        httpMethod: APIConstants.HttpMethod,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let url = URL(string: APIConstants.baseURL + endpoint) else {
            completion(.failure(ServiceError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        request.timeoutInterval = APIConstants.timeoutInterval
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(ServiceError.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(ServiceError.httpError(statusCode: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(ServiceError.noData))
                return
            }
            
            self.decodeData(data, completion: completion)
        }.resume()
    }
    
    // MARK: - Private Methods
    /// Decodes the received data into the specified type
    private func decodeData<T: Decodable>(_ data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(ServiceError.decodingError))
        }
    }
}
