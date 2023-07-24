//
//  Movie.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/21.
//

import Foundation

struct Movie: Identifiable, Equatable, Hashable {
    let id: Int
    let originalTitle: String
    let title: String
    let overview: String
    let imagePath: String
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
}

extension Movie {
    static let emptyMovie = Movie(
        id: Int.random(in: 0...10000),
        originalTitle: "originTitle",
        title: "Title",
        overview: "overview",
        imagePath: "imagePath",
        releaseDate: "date",
        voteAverage: 1.0,
        voteCount: 1)
    
    static func makeSampleMovie() -> Movie {
        return Movie(
            id: Int.random(in: 0...10000),
            originalTitle: "originTitle",
            title: "Title",
            overview: "overview",
            imagePath: "imagePath",
            releaseDate: "date",
            voteAverage: 1.0,
            voteCount: 1)
    }
    static let sampelMovieList: [Movie] = [
        Movie(id: 1, originalTitle: "movie1", title: "movie1", overview: "test Movie1", imagePath: "", releaseDate: "", voteAverage: 1.0, voteCount: 1),
        Movie(id: 2, originalTitle: "movie2", title: "movie2", overview: "test Movie2", imagePath: "", releaseDate: "", voteAverage: 1.0, voteCount: 1),
        Movie(id: 3, originalTitle: "movie3", title: "movie3", overview: "test Movie3", imagePath: "", releaseDate: "", voteAverage: 1.0, voteCount: 1),
        Movie(id: 4, originalTitle: "movie4", title: "movie4", overview: "test Movie4", imagePath: "", releaseDate: "", voteAverage: 1.0, voteCount: 1),
        Movie(id: 5, originalTitle: "movie5", title: "movie5", overview: "test Movie5", imagePath: "", releaseDate: "", voteAverage: 1.0, voteCount: 1),
        Movie(id: 6, originalTitle: "movie6", title: "movie6", overview: "test Movie6", imagePath: "", releaseDate: "", voteAverage: 1.0, voteCount: 1),
        Movie(id: 7, originalTitle: "movie7", title: "movie7", overview: "test Movie7", imagePath: "", releaseDate: "", voteAverage: 1.0, voteCount: 1),
        Movie(id: 8, originalTitle: "movie8", title: "movie8", overview: "test Movie8", imagePath: "", releaseDate: "", voteAverage: 1.0, voteCount: 1),
        Movie(id: 9, originalTitle: "movie9", title: "movie9", overview: "test Movie9", imagePath: "", releaseDate: "", voteAverage: 1.0, voteCount: 1),
        Movie(id: 10, originalTitle: "movie10", title: "movie10", overview: "test Movie10", imagePath: "", releaseDate: "", voteAverage: 1.0, voteCount: 1),
        Movie(id: 11, originalTitle: "movie11", title: "movie11", overview: "test Movie11", imagePath: "", releaseDate: "", voteAverage: 1.0, voteCount: 1),
        Movie(id: 12, originalTitle: "movie12", title: "movie12", overview: "test Movie12", imagePath: "", releaseDate: "", voteAverage: 1.0, voteCount: 1),
        Movie(id: 13, originalTitle: "movie13", title: "movie13", overview: "test Movie13", imagePath: "", releaseDate: "", voteAverage: 1.0, voteCount: 1)
    ]
}
