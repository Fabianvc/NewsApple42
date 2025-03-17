struct APIConstants {
    static let apiKey = "TU_API_KEY_AQUÍ"
    static let baseURL = "https://newsapi.org/v2/everything"
    static let timeoutInterval: TimeInterval = 15

    enum Query {
        case apple
        case google
        case microsoft
        case amazon
    }
    
    enum HttpMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    static func endpoint(for query: Query) -> String {
        "?q=\(query)&apiKey=\(apiKey)"
    }
}
