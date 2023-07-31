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
}
