struct News: Codable, Hashable {
    let title: String
    let publishedAt: String
    let urlToImage: String?
    let url: String
}
