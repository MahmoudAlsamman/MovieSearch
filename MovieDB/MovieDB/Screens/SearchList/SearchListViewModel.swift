//
//  SearchListViewModel.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 25/08/2021.
//

import Foundation

final class SearchListViewModel {
        
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
        
        apiClient.perform(request: SearchMovieRequest(apiKey: "73dc9a7cadd2b6d76b607a7f3fed304d", query: "Titatic")) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
