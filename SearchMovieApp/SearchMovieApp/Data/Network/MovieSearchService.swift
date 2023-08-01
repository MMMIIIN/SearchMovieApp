//
//  MovieSearchService.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/29.
//

import Foundation

import Moya

final class MovieSearchService {
    private let movieSearchProvider: MoyaProvider = MoyaProvider<MovieSearchEndPoint>()
    
    func fetchNowPlayingMovies() {
        self.movieSearchProvider.request(.nowPlaying) { result in
            switch result {
            case let .success(response):
                do {
                    let movieList = try JSONDecoder().decode(MoviePlayingResponseDTO.self, from: response.data)
                    dump(movieList.toMovieList())
                } catch {
                    print("error catch")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
//    func loadNowPlayingMovies() async throws -> [Movie] {
////        var dummyMovieList: [Movie] = []
//        self.movieSearchProvider.request(.nowPlaying) { result in
//            do {
//                switch result {
//                case .success(let response):
//                    let movieList = try JSONDecoder().decode(MoviePlayingResponseDTO.self, from: response.data)
////                    dummyMovieList = movieList.toMovieList()
//                case .failure(let error):
//
//                    print(error)
//                }
//            } catch {
//
//            }
//        }
////        return dummyMovieList
//    }
    
    func abc() async throws -> Result<[Movie], NetworkError> {
        return try await withCheckedThrowingContinuation { continuation in
            self.movieSearchProvider.request(.nowPlaying) { result in
                switch result {
                case .success(let response):
                    let movies = try! response.map(MoviePlayingResponseDTO.self)
//                    let movies = try? JSONDecoder().decode(MoviePlayingResponseDTO.self, from: response.data)
                    continuation.resume(returning: .success(movies.toMovieList()))
                    
                case .failure:
                    continuation.resume(throwing: NetworkError.serverError)
                }
            }
        }
    }
}

enum NetworkError: Error {
    case serverError
}
