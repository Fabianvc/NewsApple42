import UIKit

class NewsCell: UICollectionViewCell {
    // MARK: - UI Components
    private let newsImageView: NewsImageView = {
        let imageView = NewsImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: .zero, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    private func setupUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(newsImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(dateLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            newsImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            newsImageView.widthAnchor.constraint(equalToConstant: 80),
            newsImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            newsImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),

            titleLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),

            dateLabel.leadingAnchor.constraint(equalTo: newsImageView.trailingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -10)
        ])
    }

    // MARK: - Configuration
    func configure(with news: News) {
        titleLabel.text = news.title
        dateLabel.text = news.publishedAt.formattedDate()

        if let imageUrl = news.urlToImage, let url = URL(string: imageUrl) {
            newsImageView.image = nil
            newsImageView.setImageWith(url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            newsImageView.image = UIImage(named: "placeholder")
        }
    }
}
