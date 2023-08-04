//
//  MovieSearchEndPoint.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/29.
//

import Foundation

import Moya

enum MovieSearchEndPoint {
    case nowPlaying
    case searchMovie(query: String)
}

extension MovieSearchEndPoint: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        case .searchMovie:
            return "/search/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .nowPlaying:
            return .get
        case .searchMovie:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .nowPlaying:
            return .requestParameters(parameters: ["language": "ko",
                                                   "region": "KR"],
                                      encoding: URLEncoding.queryString)
        case .searchMovie(let query):
            return .requestParameters(parameters: ["language": "ko",
                                                   "region": "KR",
                                                   "query": query],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-type": "application/json",
            "authorization": "Bearer \(Bundle.main.apiKey)"
        ]
    }
    
    var sampleData: Data {
        switch self {
        case .nowPlaying:
            return .loadMockNowPlayingMovieLsit()
        case .searchMovie:
            return .loadMockMovieList()
        }
    }
}
