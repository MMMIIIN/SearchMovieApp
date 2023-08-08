//
//  MovieSearchRepositoryTest.swift
//  SearchMovieAppTests
//
//  Created by Mingwan Choi on 2023/08/01.
//

import XCTest
@testable import SearchMovieApp

final class MovieSearchRepositoryTest: XCTestCase {
    
    var repository: MovieSearchRepository!
    
    override func setUp() {
        self.repository = DefaultMovieSearchRepository(movieSearchService: MockMovieSearchService())
    }
    
    override func tearDown() {
        self.repository = nil
    }
    
    func test_loadNowPlayingMovies함수가_에러없이_정상적으로_리턴하는가() async throws {
        do {
            let movies = try await self.repository.loadNowPlayingMovies()
            XCTAssertFalse(movies.isEmpty)
        } catch {
            XCTFail("Error")
        }
    }
    
    func test_searchMovie함수가_에러없이_정상적으로_리턴하는가() async throws {
        do {
            let movies = try await self.repository.searchMovie(query: "범죄도시")
            XCTAssertFalse(movies.isEmpty)
        } catch {
            XCTFail("Error")
        }
    }
}
