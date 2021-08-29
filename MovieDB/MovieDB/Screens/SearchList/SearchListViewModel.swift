//
//  SearchListViewModel.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import Foundation
import UIKit

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

    /// Opens selected movie in Safari.
    /// - Parameter index: Selected movie index.
    func showMoreDetailsForMovie(at index: Int) {
        let movieID = movies[index].id
        guard let url = URL(string: "https://www.themoviedb.org/movie/\(movieID)") else {
            return
        }
        UIApplication.shared.open(url)
    }
}
