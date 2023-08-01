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
    let movieSearchUseCase: MovieSearchUseCase
    
    init(movieSearchUseCase: MovieSearchUseCase) {
        self.movieSearchUseCase = movieSearchUseCase
    }
    
    var movieList = PublishRelay<[Movie]>()
    
    func didSearch(query title: String) {
        let movie = self.movieSearchUseCase.searchMovie(query: title)
        self.movieList.accept([movie])
    }
    
    func loadNowPlayingMovies() async throws {
        let movies = try await self.movieSearchUseCase.loadNowPlayingMovies()
        self.movieList.accept(movies)
    }
}
