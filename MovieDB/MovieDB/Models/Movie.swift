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
    var isWatched: Bool = false
    private let releaseDate: String?
    private let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case overview, title, id
        case releaseDate, posterPath
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        id = try container.decode(Int.self, forKey: .id)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
    }
    
    func buildPosterUrl() -> URL? {
        guard let posterPath = posterPath else { return nil }
        let basePath = "https://image.tmdb.org/t/p/original"
        let posterUrl = URL(string: basePath + posterPath)
        return posterUrl
    }

    func formattedReleaseDate() -> String? {
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
