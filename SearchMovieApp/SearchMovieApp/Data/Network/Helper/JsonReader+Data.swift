//
//  JsonReader+Data.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/08/01.
//

import Foundation

extension Data {
    static func loadMockMovieList() -> Data {
        guard let path = Bundle.main.path(forResource: "MockMovieList", ofType: "json") else { return Data() }
        guard let jsonString = try? String(contentsOfFile: path) else { return Data() }
        
        guard let encodeData = jsonString.data(using: String.Encoding.utf8) else { return Data() }
        return encodeData
    }
    
    static func loadMockNowPlayingMovieLsit() -> Data {
        guard let path = Bundle.main.path(forResource: "MockNowPlayingMovieList", ofType: "json") else { return Data() }
        guard let jsonString = try? String(contentsOfFile: path) else { return Data() }
        
        guard let encodeData = jsonString.data(using: String.Encoding.utf8) else { return Data() }
        return encodeData
    }
}
