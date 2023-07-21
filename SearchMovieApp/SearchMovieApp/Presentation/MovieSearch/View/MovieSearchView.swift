//
//  MovieSearchView.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/20.
//

import FlexLayout
import PinLayout

import UIKit

final class MovieSearchView: UIView {
    
    // MARK: - ui component
    
    private let flexContainerView = UIView()
    private let movieSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    // MARK: - init
    
    override init (frame: CGRect) {
        super.init(frame: .zero)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override
    
    override func layoutSubviews() {
        self.flexContainerView.pin.all(self.pin.safeArea)
        self.flexContainerView.flex.layout(mode: .fitContainer)
    }
    
    // MARK: - func
    
    func delegationSearchBar(_ viewController: MovieSearchViewController) {
        self.movieSearchBar.delegate = viewController
    }
    
    private func setupLayout() {
        self.flexContainerView.flex.direction(.column).justifyContent(.start).define { flex in
            flex.addItem(self.movieSearchBar)
        }
        self.addSubview(self.flexContainerView)
    }
}
