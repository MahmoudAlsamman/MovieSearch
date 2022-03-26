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
    
    // MARK: - Public points of contact
    /// Subject that broadcasts  on keyboard input update.
    var inputChangedSubject = PassthroughSubject<String, Never>()
    
    /// Subject that broadcasts  on row selection in tableview.
    var onRowSelectionSubject = PassthroughSubject<Int, Never>()
    
    /// Sets tableview datasource.
    func setTableViewDataSource(to dataSource: UITableViewDataSource?) {
        tableView.dataSource = dataSource
    }
    
    /// Reloads tableview data.
    func reloadData() {
        tableView.reloadData()
    }
    
    // MARK: - View Definitions
    let emptyListImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.imagePlaceholder)
        imageView.contentMode = .center
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    private let tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(MovieCellView.self, forCellReuseIdentifier: MovieCellView.identifier)
        tb.rowHeight = Constants.rowHeight
        tb.estimatedRowHeight = UITableView.automaticDimension
        tb.backgroundColor = .clear
        tb.showsVerticalScrollIndicator = false
        return tb
    }()
    
    private let searchBar: UISearchBar = {
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
                // SearchBar constraints.
                searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
                searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
                // TableView constaints.
                tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
                // EmptyList ImageView constaints.
                emptyListImageView.topAnchor.constraint(equalTo: tableView.topAnchor),
                emptyListImageView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
                emptyListImageView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
                emptyListImageView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
            ]
        )
    }
    
    func setupProperties() {
        backgroundColor = .systemGray6
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
}

// MARK: - TableView Delegate
extension SearchListViewView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onRowSelectionSubject.send(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - SearchBar Delegate
extension SearchListViewView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        inputChangedSubject.send(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

