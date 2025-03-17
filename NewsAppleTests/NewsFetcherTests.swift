import XCTest
@testable import NewsApple

final class NewsFetcherTests: XCTestCase {
    var mockService: MockNewsService!
    var newsFetcher: NewsFetcher!

    override func setUp() {
        super.setUp()
        mockService = MockNewsService()
        newsFetcher = NewsFetcher(service: mockService)
    }

    override func tearDown() {
        mockService = nil
        newsFetcher = nil
        super.tearDown()
    }

    func testFetchNewsSuccess() {
        // Configurar el mock con datos simulados
        let mockArticles = [
            News(
                title: "Test News",
                publishedAt: "06/03/2021",
                urlToImage: "https://test.com",
                url: "https://test.com"
            )
        ]

        mockService.mockResponse = NewsResponse(articles: mockArticles)

        let expectation = self.expectation(description: "Fetch news success")

        newsFetcher.fetchNews(for: .apple) { result in
            switch result {
            case .success(let articles):
                XCTAssertEqual(articles.count, 1)
                XCTAssertEqual(articles.first?.title, "Test News")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchNewsFailure() {
        // Configurar el mock para devolver un error
        mockService.shouldReturnError = true

        let expectation = self.expectation(description: "Fetch news failure")

        newsFetcher.fetchNews(for: .apple) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
