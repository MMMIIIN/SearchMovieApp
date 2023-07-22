//
//  MovieSearchViewModel.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/21.
//

import RxSwift
import RxRelay

import Foundation

protocol MovieSearchViewModelInput {
    func didSearch(query: String)
}
protocol MovieSearchViewModelOutput {
    var movieList: PublishRelay<[Movie]> { get }
}

typealias MovieSearchViewModelInputOutput = MovieSearchViewModelInput & MovieSearchViewModelOutput

final class MovieSearchViewModel: MovieSearchViewModelInputOutput {
    let movieSearchRepository: MovieSearchRepository
    
    init(movieSearchRepository: MovieSearchRepository) {
        self.movieSearchRepository = movieSearchRepository
    }
    
    var movieList = PublishRelay<[Movie]>()
    
    func didSearch(query: String) {
        let movie = self.movieSearchRepository.searchMovie(query: query)
        self.movieList.accept([movie])
    }
}
