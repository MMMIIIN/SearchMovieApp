//
//  MovieCollectionViewCell.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/24.
//

import FlexLayout

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    func setMovieTitle(to title: String) {
        self.movieTitle.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateTitle(to title: String) {
        self.movieTitle.text = title
    }
    
    private func setupLayout() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        
        self.addSubview(self.movieTitle)
        self.flex.alignItems(.center).define { flex in
            flex.addItem(self.movieTitle)
        }
    }
    
    override func layoutSubviews() {
        self.flex.layout()
    }
}

