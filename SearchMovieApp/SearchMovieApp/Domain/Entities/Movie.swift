//
//  Movie.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/21.
//

import Foundation

struct Movie: Identifiable, Equatable {
    let id: Int
    let originalTitle: String
    let title: String
    let overview: String
    let imagePath: String
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
}
