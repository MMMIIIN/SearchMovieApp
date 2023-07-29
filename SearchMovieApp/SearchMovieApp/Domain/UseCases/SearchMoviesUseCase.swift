//
//  SearchMoviesUseCase.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/21.
//

import Foundation

protocol SearchMovieUseCase {
    func searchMovie(query: String) -> Movie
}

final class DefaultSearchMovieUseCase: SearchMovieUseCase {
    
    let searchMovieRepository: SearchMovieRepository
    
    init(repository: SearchMovieRepository) {
        self.searchMovieRepository = repository
    }
    
    func searchMovie(query: String) -> Movie {
        return .emptyMovie
    }
}
