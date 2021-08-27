//
//  SearchMoviesService.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 26/08/2021.
//

import Foundation

protocol SearchMoviesService {
    func searchForMovies(with keyword: String, completion: @escaping (Result<[Movie], APIClientError>) -> Void)
}

extension ApiClient: SearchMoviesService {
    func searchForMovies(with keyword: String, completion: @escaping (Result<[Movie], APIClientError>) -> Void) {
        
        let request = SearchMovieRequest(
            apiKey: apiKey,
            query: keyword
        )
        
        perform(request: request) { result in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
