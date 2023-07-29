//
//  MovieSearchRepository.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/21.
//

import Foundation

protocol MovieSearchRepository {
    func searchMovie(query: String) -> Movie
}

final class DefaultMovieSearchRepository: MovieSearchRepository {
    func searchMovie(query: String) -> Movie {
        // FIXME: - empty 수정
        return Movie.emptyMovie
    }
}
