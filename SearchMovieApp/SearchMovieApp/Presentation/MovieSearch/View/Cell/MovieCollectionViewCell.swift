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
    private let overView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemGray
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
    
    func updateOverView(to text: String) {
        self.overView.text = text
    }
    
    private func setupLayout() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        
        self.contentView.flex.define { flex in
            flex.addItem(self.movieTitle).marginBottom(10)
            flex.addItem(self.overView)
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        self.contentView.bounds.size.width = size.width
        self.contentView.flex.layout(mode: .adjustHeight)
        return self.contentView.frame.size
    }
}
