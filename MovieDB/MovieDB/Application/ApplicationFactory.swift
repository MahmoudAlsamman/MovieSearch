//
//  ApplicationFactory.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import Foundation

/// Class that stores all dependencies used by the app.
fileprivate final class ApplicationDependencies { }

/// Factory class that creates view controllers and injects them with proper dependencies.
final class ApplicationFactory {
    fileprivate let dependencies = ApplicationDependencies()
}

extension ApplicationFactory {
    func makeSearchListViewController() -> SearchListViewController {
        SearchListViewController(
            viewModel: SearchListViewModel()
        )
    }
}
