import UIKit

class NewsListViewController: UIViewController {
    // MARK: - Properties
    private var collectionView: UICollectionView!
    var dataSource: NewsListDataSource!
    var delegate: NewsListDelegate!

    private let viewModel: NewsViewModel
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    // MARK: - Initializer
    init(viewModel: NewsViewModel = NewsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        setupDataSource()
        setupDelegate()
        fetchNews()
    }

    // MARK: - UI Setup
    private func setupUI() {
        title = NewsListConstants.title
        view.backgroundColor = .systemBackground

        setupCollectionView()
        setupActivityIndicator()
        setupConstraints()
    }

    private func setupCollectionView() {
        let layout = NewsListLayout.createLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsListConstants.Cells.newsCellIdentifier)
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadNews), for: .valueChanged)

        view.addSubview(collectionView)
    }

    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    // MARK: - Bindings
    private func setupBindings() {
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.dataSource.applySnapshot(news: self?.viewModel.news ?? [])
                self?.refreshControl.endRefreshing()
                self?.activityIndicator.stopAnimating()
            }
        }

        viewModel.onError = { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.handleError(message: errorMessage)
            }
        }
    }

    // MARK: - Data Source
    private func setupDataSource() {
        dataSource = NewsListDataSource(collectionView: collectionView)
    }

    // MARK: - Delegate
    private func setupDelegate() {
        delegate = NewsListDelegate(dataSource: dataSource) { [weak self] news in
            self?.showNewsDetail(for: news)
        }
        collectionView.delegate = delegate
    }

    // MARK: - Data Fetching
    private func fetchNews() {
        activityIndicator.startAnimating()
        viewModel.fetchNews()
    }

    @objc private func reloadNews() {
        viewModel.fetchNews()
    }

    // MARK: - Error Handling
    private func handleError(message: String) {
        refreshControl.endRefreshing()
        activityIndicator.stopAnimating()
        showErrorAlert(message: message)
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(
            title: NewsListConstants.Error.title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: NewsListConstants.Error.button, style: .default))
        present(alert, animated: true)
    }

    private func showNewsDetail(for news: News) {
        let detailVC = NewsDetailViewController(urlString: news.url)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
