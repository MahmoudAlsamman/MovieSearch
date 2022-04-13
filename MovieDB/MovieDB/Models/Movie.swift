//
//  Movie.swift
//  MovieDB
//
//  Created by Mahmoud Alsamman on 28/08/2021.
//

import Foundation

struct Movie: Decodable {
    let overview: String?
    let title: String?
    let id: Int
    let releaseDate: String?
    private let posterPath: String?
}

extension Movie {
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        let basePath = "https://image.tmdb.org/t/p/original"
        let posterUrl = URL(string: basePath + posterPath)
        return posterUrl
    }
}
