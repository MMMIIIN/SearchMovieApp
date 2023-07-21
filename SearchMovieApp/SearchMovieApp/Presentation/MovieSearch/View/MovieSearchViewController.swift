//
//  MovieSearchViewController.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/20.
//

import UIKit

final class MovieSearchViewController: UIViewController {
    
    // MARK: - property
    
    private let movieSearchView = MovieSearchView()
    
    // MARK: - life cycle
    
    override func loadView() {
        self.view = movieSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
//        self.movieSearchView.delegationSearchBar(self)
    }
    
}

extension MovieSearchViewController: UISearchBarDelegate {
    
}
