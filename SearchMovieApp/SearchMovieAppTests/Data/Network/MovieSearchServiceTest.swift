//
//  MovieSearchServiceTest.swift
//  SearchMovieAppTests
//
//  Created by Mingwan Choi on 2023/08/01.
//

import XCTest

import Moya
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

final class MockMovieSearchService: MovieSearchService {
    func fetchNowPlayingMovies() async throws -> Result<[Movie], NetworkError> {
        let searchMovieEndpointClosure = { (target: MovieSearchEndPoint) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let provider = MoyaProvider<MovieSearchEndPoint>(endpointClosure: searchMovieEndpointClosure, stubClosure: MoyaProvider<MovieSearchEndPoint>.immediatelyStub)
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.nowPlaying) { result in
                switch result {
                case .success(let response):
                    guard let movieList = try? response.map(MoviePlayingResponseDTO.self) else { return continuation.resume(throwing: NetworkError.decodingError) }
                    continuation.resume(returning: .success(movieList.toMovieList()))
                case .failure:
                    continuation.resume(returning: .failure(.unknownError))
                }
            }
        }
    }
    
    func fetchSearchMovie(query title: String) async throws -> Result<[Movie], NetworkError> {
        let searchMovieEndpointClosure = { (target: MovieSearchEndPoint) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        let provider = MoyaProvider<MovieSearchEndPoint>(endpointClosure: searchMovieEndpointClosure, stubClosure: MoyaProvider<MovieSearchEndPoint>.immediatelyStub)
        
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.searchMovie(query: "범죄도시")) { result in
                switch result {
                case .success(let response):
                    guard let movieList = try? response.map(MovieSearchDTO.self) else { return continuation.resume(throwing: NetworkError.decodingError) }
                    continuation.resume(returning: .success(movieList.toMovieList()))
                case .failure:
                    continuation.resume(returning: .failure(.unknownError))
                }
            }
        }
    }
}
