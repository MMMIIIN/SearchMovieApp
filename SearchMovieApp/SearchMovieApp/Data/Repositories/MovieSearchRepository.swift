//
//  MovieSearchRepository.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/21.
//

import Foundation

protocol MovieSearchRepository {
    func loadNowPlayingMovies() async throws -> [Movie]
    func searchMovie(query: String) -> Movie
}

final class DefaultMovieSearchRepository: MovieSearchRepository {
    
    let movieSearchService: MovieSearchService = MovieSearchService()
    
    func searchMovie(query: String) -> Movie {
        // FIXME: - empty 수정
        return Movie.emptyMovie
    }
    
    func loadNowPlayingMovies() async throws -> [Movie] {
        let result = try await self.movieSearchService.fetchNowPlayingMovies()
        switch result {
        case .success(let movies):
            return movies
        case .failure:
            print("Error")
            return []
        }
    }
}
