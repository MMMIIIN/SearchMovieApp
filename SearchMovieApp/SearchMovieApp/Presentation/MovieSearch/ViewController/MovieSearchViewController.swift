//
//  MovieSearchViewController.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/20.
//

import RxSwift
import RxCocoa

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
    private let viewModel: MovieSearchViewModel = MovieSearchViewModel(movieSearchUseCase: DefaultMovieSearchUseCase(repository: DefaultMovieSearchRepository(movieSearchService: DefaultMovieSearchService())))
    private var disposedBag = DisposeBag()
    
    // MARK: - life cycle
    
    override func loadView() {
        self.view = movieSearchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        self.setupDiffableDataSource()
    }
    
    // MARK: - func
    
    private func bindViewModel() {
        let output = self.transformedOutput()
        self.bindOutputToView(output: output)
    }
    
    private func transformedOutput() -> MovieSearchViewModelOutput {
        let input = MovieSearchViewModelInput(
            viewDidLoad: Observable.just(()).asObservable(),
            searchMovie: self.movieSearchView.searchBar().searchTextField.rx.text.orEmpty.asObservable())
        return self.viewModel.transform(input: input)
    }
    
    private func bindOutputToView(output: MovieSearchViewModelOutput) {
        output.movieList.subscribe(onNext: { [weak self] movies in
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
            cell.updateOverView(to: item.overview)
            cell.updateImageView(to: item.imagePath)
            cell.updateVoteArange(to: item.voteAverage)
            return cell
        }
    }
}
