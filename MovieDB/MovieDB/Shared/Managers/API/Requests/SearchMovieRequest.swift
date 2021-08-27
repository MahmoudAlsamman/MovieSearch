//
//  SearchMovieRequest.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 26/08/2021.
//

import Foundation

struct SearchMovieRequest: APIRequest {
    
    typealias Response = SearchMovieResponse

    let apiKey: String
    let query: String
    
    var method: APIRequestMethod {
        .get
    }
    
    var path: String {
        "/search/movie"
    }
    
    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "query", value: query)
        ]
    }
}

struct SearchMovieResponse: APIResponse {
    let results: [Movie]
}
