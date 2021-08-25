//
//  SearchListViewController.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import UIKit

final class SearchListViewController: CodeViewController<SearchListViewView> {
    
    private let viewModel: SearchListViewModel
    
    init(customView: SearchListViewView? = nil, viewModel: SearchListViewModel) {
        self.viewModel = viewModel
        super.init(customView: customView ?? SearchListViewView())
    }
}
