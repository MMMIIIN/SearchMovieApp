//
//  MovieSearchRepositoryTest.swift
//  SearchMovieAppTests
//
//  Created by Mingwan Choi on 2023/08/01.
//

import XCTest
@testable import SearchMovieApp

final class MovieSearchRepositoryTest: XCTestCase {
    func testRequest() async throws {
        let repository = DefaultMovieSearchRepository()
        
        let movies = try await repository.loadNowPlayingMovies()
        
        print(movies)
        
        XCTAssertNotNil(movies)
    }
}
