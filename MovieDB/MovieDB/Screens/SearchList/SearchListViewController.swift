//
//  SearchListViewController.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import UIKit
import Combine

final class SearchListViewController: CodeViewController<SearchListViewView> {
    
    private let viewModel: SearchListViewModel
    
    /// Initializes view controller.
    /// - Parameters:
    ///   - customView: View to set as main view. set only for testing.
    ///   - viewModel: View model.
    init(
        customView: SearchListViewView? = nil,
        viewModel: SearchListViewModel
    ) {
        self.viewModel = viewModel
        super.init(customView: customView ?? SearchListViewView())
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.tableView.delegate = self
        customView.searchBar.delegate = self
        customView.tableView.dataSource = self
    }
    
    private func clearTableView() {
        viewModel.movies.removeAll()
        customView.tableView.reloadData()
        customView.emptyListImageView.isHidden = false
    }
    
    
    private func searchMovie(with searchText: String) {
        guard !searchText.isEmpty else {
            clearTableView()
            return
        }
        
        viewModel.searchForMovies(with: searchText) { result in
            switch result {
            case .success(let movies):
                self.viewModel.movies = movies
                self.customView.tableView.reloadData()
                self.customView.emptyListImageView.isHidden = true
            case .failure(_):
                break // TODO: - Handle errors
            }
        }
    }
}

//MARK: - TableViewDataSource
extension SearchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCellView.identifier, for: indexPath) as? MovieCellView else {
            return UITableViewCell()
        }
        
        cell.configureCell(with: viewModel.movies[indexPath.item])
        return cell
    }
}

// MARK: - TableView Delegate
extension SearchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.showMoreDetailsForMovie(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - SearchBar Delegate
extension SearchListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMovie(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
