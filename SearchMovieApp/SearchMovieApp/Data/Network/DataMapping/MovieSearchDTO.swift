//
//  MovieSearchDTO.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/08/01.
//

import Foundation

// MARK: - MovieSearchDTO
struct MovieSearchDTO: Decodable {
    let page: Int
    let results: [ResultDTO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension MovieSearchDTO {
    func toMovieList() -> [Movie] {
        return self.results.map { $0.toMovie() }
    }
}

