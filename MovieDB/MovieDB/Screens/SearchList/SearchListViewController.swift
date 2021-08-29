//
//  SearchListViewController.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import UIKit

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
        setupCallbacks()
        self.customView.setTableViewDataSource(to: self)
    }
    
    private func setupCallbacks() {
        // On keyboard input update.
        customView.inputChanged = { [weak self] keyword in
            if keyword.isEmpty {
                self?.viewModel.movies.removeAll()
                self?.customView.reloadData()
                self?.customView.emptyListImageView.isHidden = false
            }
            self?.viewModel.searchForMovies(with: keyword) { result in
                switch result {
                case .success(let movies):
                    self?.viewModel.movies = movies
                    self?.customView.reloadData()
                    self?.customView.emptyListImageView.isHidden = true
                case .failure(_):
                    break // TODO: - Handle errors
                }
            }
        }
        // On row selection.
        customView.onRowSelection = { [weak self] index in
            self?.viewModel.showMoreDetailsForMovie(at: index)
        }
    }
}

//MARK: - TableViewDataSource
extension SearchListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCellView.id, for: indexPath) as! MovieCellView
        cell.configureCell(with: viewModel.movies[indexPath.item])
        cell.onIsWatchedTap = { [weak self] in
            self?.viewModel.movies[indexPath.item].isWatched.toggle()
            tableView.reloadData()
        }
        return cell
    }
}
