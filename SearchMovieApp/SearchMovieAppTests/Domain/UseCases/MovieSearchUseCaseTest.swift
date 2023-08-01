//
//  MovieSearchUseCaseTest.swift
//  SearchMovieAppTests
//
//  Created by Mingwan Choi on 2023/08/01.
//

import XCTest
@testable import SearchMovieApp

final class MovieSearchUseCaseTest: XCTestCase {
    func testRequest() async throws {
        let usecase = DefaultMovieSearchUseCase(repository: DefaultMovieSearchRepository())
        
        let movies = try await usecase.loadNowPlayingMovies()
        
        print(movies)
        
        XCTAssertNotNil(movies)
    }
}
