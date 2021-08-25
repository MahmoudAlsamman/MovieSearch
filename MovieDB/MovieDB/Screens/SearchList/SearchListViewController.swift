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
    }
    
    private func setupCallbacks() {
        
    }
}
