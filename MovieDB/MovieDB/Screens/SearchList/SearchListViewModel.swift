//
//  SearchListViewModel.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import Foundation

final class SearchListViewModel {
    
    /// ApiClient.
    private let apiClient: SearchMoviesService
    /// List of movies.
    var movies: [Movie] = []
    
    init(apiClient: SearchMoviesService) {
        self.apiClient = apiClient
    }
    
    /// Makes a request to backend and returns list of movies found containing sesrch keyword.
    /// - Parameters:
    ///   - keyWord: Search keyword.
    ///   - completion:
    ///     - Success: List of Movies
    ///     - Failure: Error type
    func searchForMovies(
        with keyWord: String,
        completion: @escaping (Result<[Movie], APIClientError>) -> Void
    ) {
        apiClient.searchForMovies(with: keyWord, completion: completion)
    }
}
