//
//  MovieSearchViewController.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/20.
//

import RxSwift

import UIKit

final class MovieSearchViewController: UIViewController {
    
    // MARK: - property
    
    private let movieSearchView = MovieSearchView()
    
    private let viewModel: MovieSearchViewModel = MovieSearchViewModel(movieSearchRepository: MovieSearchRepository())
    private var disposedBag = DisposeBag()
    
    // MARK: - life cycle
    
    override func loadView() {
        self.view = movieSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.bind()
        self.movieSearchView.delegationSearchBar(self)
    }
    
    // MARK: - func
    
    private func bind() {
        self.viewModel.movieList
            .subscribe { [weak self] movie in
                self?.movieSearchView.updateMovieTitleLabel(to: movie.element![0].title)
            }
            .disposed(by: self.disposedBag)
    }
}

extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        self.viewModel.didSearch(query: searchText)
    }
}
