//
//  MovieSearchUseCase.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/21.
//

import Foundation

protocol MovieSearchUseCase {
    func searchMovie(query: String) async throws -> [Movie]
    func loadNowPlayingMovies() async throws -> [Movie]
}

final class DefaultMovieSearchUseCase: MovieSearchUseCase {
    
    let searchMovieRepository: MovieSearchRepository
    
    init(repository: MovieSearchRepository) {
        self.searchMovieRepository = repository
    }
    
    func searchMovie(query: String) async throws -> [Movie] {
        let movieList = try await self.searchMovieRepository.searchMovie(query: query)
        return movieList
    }
    
    func loadNowPlayingMovies() async throws -> [Movie] {
        return try await self.searchMovieRepository.loadNowPlayingMovies()
    }
}
