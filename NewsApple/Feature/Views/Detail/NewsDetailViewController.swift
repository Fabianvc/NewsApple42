import UIKit
import WebKit

class NewsDetailViewController: UIViewController {
    // MARK: - Properties
    private let webView: WKWebView
    private let urlString: String

    // MARK: - Initializer
    init(urlString: String, webView: WKWebView = WKWebView()) {
        self.urlString = urlString
        self.webView = webView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebView()
    }

    // MARK: - UI Setup
    /// Configures the user interface
    private func setupUI() {
        view.addSubview(webView)
        webView.frame = view.bounds
    }

    /// Loads the URL into the web view
    private func loadWebView() {
        guard let url = URL(string: urlString) else {
            // Handle invalid URL (e.g., show an alert or log an error)
            print("Invalid URL: \(urlString)")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
