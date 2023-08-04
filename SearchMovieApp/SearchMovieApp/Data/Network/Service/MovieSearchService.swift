//
//  MovieSearchService.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/29.
//

import Foundation

import Moya

protocol MovieSearchService {
    func fetchNowPlayingMovies() async throws -> Result<[Movie], NetworkError>
    func fetchSearchMovie(query title: String) async throws -> Result<[Movie], NetworkError>
}

final class DefaultMovieSearchService: MovieSearchService {
    private let movieSearchProvider: MoyaProvider<MovieSearchEndPoint>
    
    init(movieSearchProvider: MoyaProvider<MovieSearchEndPoint> = MoyaProvider<MovieSearchEndPoint>()) {
        self.movieSearchProvider = movieSearchProvider
    }
    
    func fetchNowPlayingMovies() async throws -> Result<[Movie], NetworkError> {
        return try await withCheckedThrowingContinuation { continuation in
            self.movieSearchProvider.request(.nowPlaying) { result in
                switch result {
                case .success(let response):
                    let movies = try! response.map(MoviePlayingResponseDTO.self)
                    continuation.resume(returning: .success(movies.toMovieList()))
                case .failure:
                    continuation.resume(throwing: NetworkError.serverError)
                }
            }
        }
    }
    
    func fetchSearchMovie(query title: String) async throws -> Result<[Movie], NetworkError> {
        return try await withCheckedThrowingContinuation { continuation in
            self.movieSearchProvider.request(.searchMovie(query: title)) { result in
                switch result {
                case .success(let response):
                    let movies = try! response.map(MovieSearchDTO.self)
                    continuation.resume(returning: .success(movies.toMovieList()))
                case .failure:
                    continuation.resume(throwing: NetworkError.serverError)
                }
            }
        }
    }
}

// FIXME: - 위치 수정
enum NetworkError: Error {
    case decodingError
    case serverError
    case unknownError
}
