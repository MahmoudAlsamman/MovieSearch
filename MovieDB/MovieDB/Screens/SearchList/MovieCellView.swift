//
//  MovieCellView.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import UIKit
import SDWebImage

final class MovieCellView: CodeTableViewCell {
    
    // MARK: - Constants
    
    /// Cell Identifier.
    static let id = "MovieCellView"
    
    enum Constatnts {
        static let posterWidth: CGFloat = 150
        static let edgePadding: CGFloat = 20
        static let buttonWidth: CGFloat = 100
        static let buttonHeight: CGFloat = 40
        static let horizontalPadding: CGFloat = 5
    }
    
    // MARK: - Properties
    
    /// Callback when watch button tapped.
    var onIsWatchedTap: (() -> Void)?
    
    //MARK: - Methods
    
    func configureCell(with movie: Movie) {
        movieTitleLabel.text = movie.title
        movieOverviewLabel.text = movie.overview
        releaseDateLabel.text = movie.formattedReleaseDate()
        isWatchedButton.setTitle(movie.isWatched ? "Watched" : "Not Watched", for: .normal)
        isWatchedButton.backgroundColor = movie.isWatched ? .systemGreen: .systemRed
        moviePosterImage.sd_setImage(
            with: movie.buildPosterUrl(),
            placeholderImage: UIImage(named: "movie_placeholder")
        )
    }
    
    //MARK: - Lifecycle
    
    override func setupLayout() {
        setupViewHierarchy()
        setupConstraints()
        backgroundColor = .systemGray6
    }
    
    //MARK: - Setup View Hierarchy
    
    private func setupViewHierarchy() {
        contentView.addSubviews(
            moviePosterImage,
            isWatchedButton,
            movieTitleLabel,
            releaseDateLabel,
            movieOverviewLabel
        )
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                // MoviePoster.
                moviePosterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constatnts.edgePadding),
                moviePosterImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constatnts.edgePadding),
                moviePosterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constatnts.edgePadding),
                moviePosterImage.widthAnchor.constraint(equalToConstant: Constatnts.posterWidth),
                // WatchButton.
                isWatchedButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constatnts.edgePadding),
                isWatchedButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constatnts.edgePadding),
                isWatchedButton.widthAnchor.constraint(equalToConstant: Constatnts.buttonWidth),
                isWatchedButton.heightAnchor.constraint(equalToConstant: Constatnts.buttonHeight),
                // MovieTitle.
                movieTitleLabel.topAnchor.constraint(equalTo: moviePosterImage.topAnchor),
                movieTitleLabel.leadingAnchor.constraint(equalTo: moviePosterImage.trailingAnchor),
                movieTitleLabel.trailingAnchor.constraint(equalTo: isWatchedButton.leadingAnchor, constant: -Constatnts.horizontalPadding),
                // ReleaseDate.
                releaseDateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: Constatnts.horizontalPadding),
                releaseDateLabel.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
                releaseDateLabel.trailingAnchor.constraint(equalTo: isWatchedButton.leadingAnchor, constant: -Constatnts.horizontalPadding),
                // MovieOverview.
                movieOverviewLabel.topAnchor.constraint(equalTo: isWatchedButton.bottomAnchor, constant: Constatnts.horizontalPadding),
                movieOverviewLabel.leadingAnchor.constraint(equalTo: movieTitleLabel.leadingAnchor),
                movieOverviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constatnts.edgePadding),
                movieOverviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constatnts.edgePadding)
            ]
        )
    }
    
    //MARK: - View Properties
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()
    
    private let moviePosterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.sd_imageTransition = .fade
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        return imageView
    }()
    
    private lazy var isWatchedButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onTapWatchButton(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    @objc
    private func onTapWatchButton(_ sender: Any) {
        isWatchedButton.transform = .init(rotationAngle: 0.5)
        // Adds rotate effect animation.
        UIView.animate(
            withDuration: 1,
            delay: 0, usingSpringWithDamping: 0.2,
            initialSpringVelocity: 1,
            options: .curveLinear,
            animations: {
                self.isWatchedButton.transform = CGAffineTransform.identity
            }, completion: { _ in
                self.onIsWatchedTap?()
            }
        )
    }
}
