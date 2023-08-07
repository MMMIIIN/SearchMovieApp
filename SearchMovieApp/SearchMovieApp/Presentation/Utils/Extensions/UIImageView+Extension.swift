//
//  UIImageView+Extension.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/08/07.
//

import UIKitSearchMovieApp/Presentation/Utils/Extensions/UIFont+Extension.swift

extension UIImageView {
    func load(url: String) {
        DispatchQueue.global().async { [weak self] in
            guard let fullUrl = URL(string: "https://image.tmdb.org/t/p/w154\(url)")  else { return }
            if let data = try? Data(contentsOf: fullUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
