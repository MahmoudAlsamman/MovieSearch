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
    let releaseDate: String?
    let posterPath: String?
    let id: Int
    var isWatched: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case overview, title, id
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        id = try container.decode(Int.self, forKey: .id)
    }
    
    func buildPosterUrl() -> URL? {
        guard let posterPath = posterPath else { return nil }
        let basePath = "https://image.tmdb.org/t/p/original"
        let posterUrl = URL(string: basePath + posterPath)
        return posterUrl
    }
}
