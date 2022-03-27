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
    static let identifier = "MovieCellView"
    
    enum Constatnts {
        static let posterWidth: CGFloat = 140.0
        static let posterHeight: CGFloat = 180.0
        static let edgePadding: CGFloat = 20.0
        static let defaultHeight: CGFloat = 180.0
        static let numberOfLines: Int = 1
        static let shadowRadius: CGFloat = 10.0
        static let shadowOpacity: Float = 0.5
        static let moviewPlaceholderImage = UIImage(named: "movie_placeholder")
    }
    
    //MARK: - View Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.numberOfLines = Constatnts.numberOfLines
        label.textColor = .label
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.numberOfLines = Constatnts.numberOfLines
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.textColor = .secondaryLabel
        label.backgroundColor = .clear
        label.numberOfLines = .zero
        return label
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.shadowOpacity = Constatnts.shadowOpacity
        imageView.layer.shadowRadius = Constatnts.shadowRadius
        imageView.contentMode = .scaleToFill
        imageView.sd_imageTransition = .fade
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        return imageView
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .top
        return stackView
    }()
    
    //MARK: - Lifecycle
    override func setupLayout() {
        setupViewHierarchy()
        setupConstraints()
        backgroundColor = .systemGray6
    }
    
    
    //MARK: - Methods
    func configureCell(with movie: Movie) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        releaseDateLabel.text = movie.formattedReleaseDate
        posterImageView.sd_setImage(
            with: movie.posterURL,
            placeholderImage: Constatnts.moviewPlaceholderImage
        )
    }
    
    //MARK: - Setup View Hierarchy
    private func setupViewHierarchy() {
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(releaseDateLabel)
        labelsStackView.addArrangedSubview(overviewLabel)
        contentView.addSubviews(posterImageView, labelsStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constatnts.edgePadding),
                posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constatnts.edgePadding),
                posterImageView.heightAnchor.constraint(equalToConstant: Constatnts.posterHeight),
                posterImageView.widthAnchor.constraint(equalToConstant: Constatnts.posterWidth),
                
                labelsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constatnts.edgePadding),
                labelsStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: Constatnts.edgePadding),
                labelsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constatnts.edgePadding),
                labelsStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constatnts.defaultHeight),
                
                contentView.bottomAnchor.constraint(equalTo: labelsStackView.bottomAnchor, constant: Constatnts.edgePadding),
            ]
        )
    }
}
