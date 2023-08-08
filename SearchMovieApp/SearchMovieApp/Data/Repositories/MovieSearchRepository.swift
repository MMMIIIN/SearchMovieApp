//
//  MovieSearchRepository.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/21.
//

import Foundation

protocol MovieSearchRepository {
    func searchMovie(query title: String) async throws -> [Movie]
    func loadNowPlayingMovies() async throws -> [Movie]
}

final class DefaultMovieSearchRepository: MovieSearchRepository {
    
    let movieSearchService: MovieSearchService
    
    init(movieSearchService: MovieSearchService) {
        self.movieSearchService = movieSearchService
    }
    
    func searchMovie(query title: String) async throws -> [Movie] {
        let result = try await self.movieSearchService.fetchSearchMovie(query: title)
        switch result {
        case .success(let movies):
            return movies
        case .failure:
            throw NetworkError.serverError
        }
    }
    
    func loadNowPlayingMovies() async throws -> [Movie] {
        let result = try await self.movieSearchService.fetchNowPlayingMovies()
        switch result {
        case .success(let movies):
            return movies
        case .failure:
            throw NetworkError.serverError
        }
    }
}
