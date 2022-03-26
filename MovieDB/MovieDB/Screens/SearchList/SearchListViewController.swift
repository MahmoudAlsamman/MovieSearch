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
    private var disposeBag = Set<AnyCancellable>()
    
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
        setupBindings()
        self.customView.setTableViewDataSource(to: self)
    }
    
    private func setupBindings() {
        // On keyboard input update.
        customView.inputChangedSubject
            .sink { [weak self] keyword in
                guard let self = self, !keyword.isEmpty else {
                    self?.clearTableView()
                    return
                }
                
                self.viewModel.searchForMovies(with: keyword) { result in
                    switch result {
                    case .success(let movies):
                        self.viewModel.movies = movies
                        self.customView.reloadData()
                        self.customView.emptyListImageView.isHidden = true
                    case .failure(_):
                        break // TODO: - Handle errors
                    }
                }
            }
            .store(in: &disposeBag)
        // On row selection.
        customView.onRowSelectionSubject
            .sink { [weak self] index in
                self?.viewModel.showMoreDetailsForMovie(at: index)
            }
            .store(in: &disposeBag)
    }
    
    private func clearTableView() {
        viewModel.movies.removeAll()
        customView.reloadData()
        customView.emptyListImageView.isHidden = false
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
