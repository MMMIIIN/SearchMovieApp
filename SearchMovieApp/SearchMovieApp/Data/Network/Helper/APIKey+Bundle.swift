//
//  APIKey+Bundle.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/29.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let file = self.path(forResource: "ApiInfo", ofType: "plist") else { return "ApiInfo 파일이 없습니다." }
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["API_KEY"] as? String else { fatalError("API키를 입력해 주세요") }
        return key
    }
}
