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
    private let releaseDate: String?
    private let posterPath: String?
}

extension Movie {
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        let basePath = "https://image.tmdb.org/t/p/original"
        let posterUrl = URL(string: basePath + posterPath)
        return posterUrl
    }
    
    var formattedReleaseDate: String? {
        let formatter = DateFormatter()
        // Date string format from backend.
        formatter.dateFormat = "yyyy-mm-dd"
        guard let dateString = releaseDate,
              let date = formatter.date(from: dateString) else {
            return nil
            
        }
        // Desired date format.
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }
}
