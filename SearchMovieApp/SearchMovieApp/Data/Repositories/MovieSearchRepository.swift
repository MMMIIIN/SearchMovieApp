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
    
    let movieSearchService: MovieSearchService = MovieSearchService()
    
    func searchMovie(query: String) -> Movie {
        self.movieSearchService.fetchNowPlayingMovies()
        // FIXME: - empty 수정
        return Movie.emptyMovie
    }
}
