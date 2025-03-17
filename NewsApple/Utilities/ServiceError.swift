enum ServiceError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case noData
    case decodingError
    case httpError(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .invalidResponse:
            return "The response from the server is invalid."
        case .noData:
            return "No data was received from the server."
        case .decodingError:
            return "Failed to decode the response."
        case .httpError(let statusCode):
            return "HTTP error with status code: \(statusCode)."
        }
    }
}
