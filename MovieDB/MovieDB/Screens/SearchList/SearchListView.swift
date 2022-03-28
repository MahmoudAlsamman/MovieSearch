//
//  SearchListView.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import UIKit
import Combine

final class SearchListViewView: CodeView {
    
    // MARK: - Constants
    enum Constants {
        static let imagePlaceholder: String = "projector"
        static let searchPlaceholder: String = "Type to search..."
        static let rowHeight: CGFloat = 200.0
    }
    
    // MARK: - View Definitions
    private(set) var emptyListImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.imagePlaceholder)
        imageView.contentMode = .center
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    private(set) var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(MovieCellView.self, forCellReuseIdentifier: MovieCellView.identifier)
        tb.rowHeight = Constants.rowHeight
        tb.estimatedRowHeight = UITableView.automaticDimension
        tb.backgroundColor = .clear
        tb.keyboardDismissMode = .onDrag
        tb.showsVerticalScrollIndicator = false
        return tb
    }()
    
    private(set) var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = Constants.searchPlaceholder
        searchBar.sizeToFit()
        searchBar.searchBarStyle = .minimal
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
}
// MARK: - View Hierarchy
extension SearchListViewView: ViewSetupable {
    
    func setupViewHierarchy() {
        addSubviews(searchBar, tableView)
        addSubview(emptyListImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate(
            [
                // SearchBar
                searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
                // TableView
                tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
                // EmptyList ImageView
                emptyListImageView.topAnchor.constraint(equalTo: tableView.topAnchor),
                emptyListImageView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
                emptyListImageView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
                emptyListImageView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
            ]
        )
    }
    
    func setupProperties() {
        backgroundColor = .systemGray6
        searchBar.becomeFirstResponder()
    }
}
