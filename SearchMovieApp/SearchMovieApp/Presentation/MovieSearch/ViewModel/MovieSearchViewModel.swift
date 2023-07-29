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
    let searchMovieUseCase: SearchMovieUseCase
    
    init(searchMovieUseCase: SearchMovieUseCase) {
        self.searchMovieUseCase = searchMovieUseCase
    }
    
    var movieList = PublishRelay<[Movie]>()
    
    func didSearch(query title: String) {
        let movie = self.searchMovieUseCase.searchMovie(query: title)
        self.movieList.accept([movie])
    }
}
