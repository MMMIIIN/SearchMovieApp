//
//  MovieSearchViewModelTest.swift
//  SearchMovieAppTests
//
//  Created by Mingwan Choi on 2023/08/01.
//

import XCTest

import RxSwift
import RxTest

@testable import SearchMovieApp

final class MovieSearchViewModelTest: XCTestCase {
    var viewModel: MovieSearchViewModel!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        self.viewModel = MovieSearchViewModel(movieSearchUseCase: DefaultMovieSearchUseCase(repository: DefaultMovieSearchRepository(movieSearchService: MockMovieSearchService())))
        self.scheduler = TestScheduler(initialClock: 0)
        self.disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.scheduler = nil
        self.disposeBag = nil
    }
    
    func test_transfer의_viewDidLoad란_input이_올바른_output을_리턴하는가() {
        // given
        let expectation = XCTestExpectation(description: "viewDidLoad Async")
        
        let viewDidLoadObservable = self.scheduler.createColdObservable([
            .next(200, ())
        ])
        
        let loadMovieTestableObserver = self.scheduler.createObserver([Movie].self)
        
        let input = MovieSearchViewModelInput(
            viewDidLoad: viewDidLoadObservable.asObservable(),
            searchMovie: Observable.never())
        
        // when
        self.viewModel.transform(input: input)
            .movieList
            .subscribe(onNext: { movies in
                loadMovieTestableObserver.onNext(movies)
                expectation.fulfill()
            })
            .disposed(by: self.disposeBag)
        
        self.scheduler.start()
        
        // then
        wait(for: [expectation], timeout: 2)
        
        XCTAssertEqual(loadMovieTestableObserver.events, [
            .next(200, Movie.dummytNowPlayingMovieList)
        ])
    }
    
    func test_transfer의_searchMovie란_input이_올바른_output을_리턴하는가() {
        // given
        let expectation = XCTestExpectation(description: "search Async")
        
        let searchObservable = self.scheduler.createColdObservable([
            .next(210, "범죄도시")
        ])
        
        let loadMovieTestableObserver = self.scheduler.createObserver([Movie].self)
        
        let input = MovieSearchViewModelInput(
            viewDidLoad: Observable.never(),
            searchMovie: searchObservable.asObservable())
        
        // when
        self.viewModel.transform(input: input).movieList
            .subscribe(onNext: { movies in
                loadMovieTestableObserver.onNext(movies)
                expectation.fulfill()
            }).disposed(by: self.disposeBag)
        
        self.scheduler.start()
        
        // then
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(loadMovieTestableObserver.events, [
            .next(210, Movie.dummySearchMovieList)
        ])
    }
}
