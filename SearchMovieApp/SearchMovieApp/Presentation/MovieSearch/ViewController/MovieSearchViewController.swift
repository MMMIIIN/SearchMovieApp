//
//  MovieSearchViewController.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/20.
//

import RxSwift

import UIKit

final class MovieSearchViewController: UIViewController {
    
    private enum Section: CaseIterable {
        case main
    }
    
    private typealias DiffalbleDataSource = UICollectionViewDiffableDataSource<Section, Movie>
    
    // MARK: - ui component
    
    private let movieSearchView = MovieSearchView()
    
    // MARK: - property
    
    private var dataSource: DiffalbleDataSource!
    private let viewModel: MovieSearchViewModel = MovieSearchViewModel(movieSearchUseCase: DefaultMovieSearchUseCase(repository: DefaultMovieSearchRepository()))
    private var disposedBag = DisposeBag()
    
    // MARK: - life cycle
    
    override func loadView() {
        self.view = movieSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.loadData()
        self.bind()
        self.movieSearchView.delegationSearchBar(self)
        self.setupDiffableDataSource()
    }
    
    // MARK: - func
    
    private func loadData() {
        Task {
            try await self.viewModel.loadNowPlayingMovies()
        }
    }
    
    private func bind() {
        self.viewModel.movieList.subscribe(onNext: { [weak self] movies in
            var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
            snapshot.appendSections([.main])
            snapshot.appendItems(movies)
            self?.dataSource.apply(snapshot, animatingDifferences: true)
        })
        .disposed(by: self.disposedBag)
    }
    
    private func setupDiffableDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: self.movieSearchView.collectionView()) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MovieCollectionViewCell else {
                return nil
            }
            cell.updateTitle(to: item.title)
            return cell
        }
    }
    
    func performQuery(with text: String) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        let arr = Movie.sampelMovieList.filter { $0.title.contains(text) }
        snapshot.appendItems(arr, toSection: .main)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension MovieSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        self.performQuery(with: searchText)
        self.viewModel.didSearch(query: searchText)
    }
}