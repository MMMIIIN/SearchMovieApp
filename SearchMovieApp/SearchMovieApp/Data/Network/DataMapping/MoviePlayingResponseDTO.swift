//
//  MoviePlayingResponseDTO.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/31.
//

import Foundation

struct MoviePlayingResponseDTO: Decodable {
    let dates: DatesDTO
    let page: Int
    let results: [ResultDTO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct DatesDTO: Decodable {
    let maximum, minimum: String
}

struct ResultDTO: Decodable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Mapping

extension MoviePlayingResponseDTO {
    func toMovieList() -> [Movie] {
        return self.results.map { $0.toMovie() }
    }
}

extension ResultDTO {
    func toMovie() -> Movie {
        return .init(id: self.id,
                     originalTitle: self.originalTitle,
                     title: self.title,
                     overview: self.overview,
                     imagePath: self.posterPath,
                     releaseDate: self.releaseDate,
                     voteAverage: self.voteAverage,
                     voteCount: self.voteCount)
    }
}
