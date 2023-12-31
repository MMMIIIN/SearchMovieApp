//
//  MovieSearchViewModel.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/21.
//

import RxSwift
import RxRelay

import Foundation

struct MovieSearchViewModelInput {
    let viewDidLoad: Observable<Void>
    let searchMovie: Observable<String>
}

struct MovieSearchViewModelOutput {
    var movieList: PublishRelay<[Movie]>
}

final class MovieSearchViewModel {
    
    // MARK: - property
    
    private var disposedBag: DisposeBag = DisposeBag()
    var movieList = PublishRelay<[Movie]>()
    
    let movieSearchUseCase: MovieSearchUseCase
    
    init(movieSearchUseCase: MovieSearchUseCase) {
        self.movieSearchUseCase = movieSearchUseCase
    }
    
    // MARK: - func
    
    func transform(input: MovieSearchViewModelInput) -> MovieSearchViewModelOutput {
        input.viewDidLoad
            .withUnretained(self)
            .subscribe(onNext: { _ in
                self.loadNowPlayingMovies()
            })
            .disposed(by: self.disposedBag)
        
        input.searchMovie
            .filter { !$0.isEmpty }
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe(onNext: { _, title in
                self.searchMovie(query: title)
            })
            .disposed(by: self.disposedBag)
        
        return MovieSearchViewModelOutput(movieList: self.movieList)
    }
    
    func loadNowPlayingMovies() {
        Task {
            let movies = try await self.movieSearchUseCase.loadNowPlayingMovies()
            self.movieList.accept(movies)
        }
    }
    
    func searchMovie(query title: String) {
        Task {
            let movies = try await self.movieSearchUseCase.searchMovie(query: title)
            self.movieList.accept(movies)
        }
    }
}
