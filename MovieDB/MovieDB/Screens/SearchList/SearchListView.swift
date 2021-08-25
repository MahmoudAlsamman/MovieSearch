//
//  SearchListView.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import UIKit

final class SearchListViewView: CodeView {
    
    // MARK: - Public points of contact
    
    var inputChanged: ((String) -> Void)?
    var onRowSelection: ((_ index: Int) -> Void)?
    
    // MARK: - View Definitions
    
    private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(MovieCellView.self, forCellReuseIdentifier: MovieCellView.id)
        tb.rowHeight = 70
        tb.backgroundColor = .clear
        tb.showsVerticalScrollIndicator = false
        tb.delegate = self
        return tb
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Something here"
        searchBar.sizeToFit()
        searchBar.searchBarStyle = .prominent
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    // MARK: - LifeCycle
    
    init() {
        super.init(frame: .zero)
        searchBar.delegate = self
    }
}
// MARK: - View Hierarchy
extension SearchListViewView: ViewSetupable {
    
    func setupViewHierarchy() {
        addSubviews(searchBar, tableView)
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
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]
        )
    }
    
    func setupProperties() {
        backgroundColor = .white
    }
}

extension SearchListViewView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onRowSelection?(indexPath.row)
    }
}

// MARK: - SearchBar Delegate
extension SearchListViewView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        inputChanged?(searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
