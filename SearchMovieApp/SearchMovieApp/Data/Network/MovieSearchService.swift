//
//  MovieSearchService.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/29.
//

import Foundation

import Moya

final class MovieSearchService {
    private let movieSearchProvider: MoyaProvider = MoyaProvider<MovieSearchEndPoint>()
    
    func fetchNowPlayingMovies() {
        self.movieSearchProvider.request(.nowPlaying) { result in
            switch result {
            case let .success(response):
                do {
                    let movieList = try JSONDecoder().decode(MovieList.self, from: response.data)
                    print(movieList)
                } catch {
                    print("error catch")
                }
                
            case let .failure(error):
                print(error)
            }
        }
    }
}

// MARK: - MovieList
struct MovieList: Codable {
    let dates: Dates
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}

// MARK: - Result
struct Result: Codable {
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
