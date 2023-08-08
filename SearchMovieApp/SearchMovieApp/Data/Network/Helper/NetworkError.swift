//
//  NetworkError.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/08/08.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case serverError
    case unknownError
}
