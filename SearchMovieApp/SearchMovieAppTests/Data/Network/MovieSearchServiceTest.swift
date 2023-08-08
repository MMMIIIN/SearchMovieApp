//
//  MovieSearchServiceTest.swift
//  SearchMovieAppTests
//
//  Created by Mingwan Choi on 2023/08/01.
//

import XCTest

@testable import SearchMovieApp

final class MovieSearchServiceTest: XCTestCase {
    
    var service: MovieSearchService!
    
    override func setUp() {
        self.service = MockMovieSearchService()
    }
    
    override func tearDown() {
        self.service = nil
    }
    
    func test_fetchNowPlayingMovies란_함수가_있는가() async throws {
        let _ = try await self.service.fetchNowPlayingMovies()
    }
    
    func test_fetchSearchMovie란_함수가있는가() async throws {
        let _ = try await self.service.fetchSearchMovie(query: "")
    }
    
    func test_searchMovie함수가_올바르게_디코딩되는가() async throws {
        // given
        let mockService = MockMovieSearchService()
        // when
        let result = try await mockService.fetchSearchMovie(query: "범죄도시")
        // then
        switch result {
        case .success(let movieList):
            XCTAssertNotNil(movieList)
        case .failure(let error):
            switch error {
            case .unknownError:
                XCTAssertTrue(false, "unknown Error")
            case .decodingError:
                XCTAssertTrue(false, "decoding Error")
            default:
                XCTAssertTrue(false, "Error")
            }
        }
    }
    
    func test_nowPlaying함수가_올바르게_디코딩되는가() async throws {
        // given
        let mockService = MockMovieSearchService()
        // when
        let result = try await mockService.fetchNowPlayingMovies()
        
        // then
        switch result {
        case .success(let movieList):
            XCTAssertNotNil(movieList)
        case .failure(let error):
            switch error {
            case .unknownError:
                XCTAssertTrue(false, "unknown Error")
            case .decodingError:
                XCTAssertTrue(false, "decoding Error")
            default:
                XCTAssertTrue(false, "Error")
            }
        }
    }
}
