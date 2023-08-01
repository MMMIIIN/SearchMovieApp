//
//  MovieSearchServiceTest.swift
//  SearchMovieAppTests
//
//  Created by Mingwan Choi on 2023/08/01.
//

import XCTest
@testable import SearchMovieApp

final class MovieSearchServiceTest: XCTestCase {
    func testRequest() async throws {
        let service = MovieSearchService()
        
        let result = try await service.abc()
        
        let movies = try result.get()
        
        XCTAssertNotNil(movies)
    }
}
