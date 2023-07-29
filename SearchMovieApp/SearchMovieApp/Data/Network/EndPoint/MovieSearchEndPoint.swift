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
}

extension MovieSearchEndPoint: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "/movie/now_playing"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .nowPlaying:
            return .get
        }
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return [
            "Content-type": "application/json",
            "language": "ko",
            "region": "KR",
            "authorization": "Bearer ENTER_YOUR_API_KEY"
        ]
    }
}
