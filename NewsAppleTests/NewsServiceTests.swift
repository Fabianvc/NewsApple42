import XCTest
@testable import NewsApple

final class NewsServiceTests: XCTestCase {
    var newsService: NewsService!

    override func setUp() {
        super.setUp()
        newsService = NewsService()
    }

    override func tearDown() {
        newsService = nil
        super.tearDown()
    }

    func testPerformRequestSuccess() {
        let expectation = self.expectation(description: "Perform request success")
        let endpoint = APIConstants.endpoint(for: .apple)
        newsService.performRequest(endpoint: endpoint, httpMethod: .get) { (result: Result<NewsResponse, Error>) in
            switch result {
            case .success(let response):
                XCTAssertGreaterThan(response.articles.count, 1)
                XCTAssertNotNil(response.articles.first?.title)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testPerformRequestFailure() {
        let expectation = self.expectation(description: "Perform request failure")

        newsService.performRequest(endpoint: "/test", httpMethod: .get) { (result: Result<NewsResponse, Error>) in
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
