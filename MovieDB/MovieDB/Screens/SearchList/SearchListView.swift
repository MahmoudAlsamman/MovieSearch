//
//  SearchListView.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import UIKit

final class SearchListViewView: CodeView {
    
    // MARK: - Public points of contact
    
    /// Callback on keyboard input update.
    var inputChanged: ((String) -> Void)?
    
    /// Callback on row selection in tableview.
    var onRowSelection: ((_ index: Int) -> Void)?
    
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
        imageView.image = UIImage(named: "projector")
        imageView.contentMode = .center
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
     private lazy var tableView: UITableView = {
        let tb = UITableView()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(MovieCellView.self, forCellReuseIdentifier: MovieCellView.id)
        tb.rowHeight = 200
        tb.backgroundColor = .clear
        tb.showsVerticalScrollIndicator = false
        tb.delegate = self
        return tb
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Type to search..."
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
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
    }
}

// MARK: - TableView Delegate
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
