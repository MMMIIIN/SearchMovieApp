//
//  MockMovieSearchService.swift
//  SearchMovieAppTests
//
//  Created by Mingwan Choi on 2023/08/08.
//

import Foundation

import Moya
@testable import SearchMovieApp

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

