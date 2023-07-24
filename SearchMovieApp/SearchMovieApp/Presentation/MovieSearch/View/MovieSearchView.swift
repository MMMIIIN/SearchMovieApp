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
    private lazy var movieCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createCollectionViewLayout())
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
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
        self.flexContainerView.flex.layout()
    }
    
    // MARK: - func
    
    func delegationSearchBar(_ viewController: MovieSearchViewController) {
        self.movieSearchBar.delegate = viewController
    }
    
    func collectionView() -> UICollectionView {
        return self.movieCollectionView
    }
    
    private func setupLayout() {
        self.addSubview(flexContainerView)
        
        self.flexContainerView.flex.direction(.column).alignItems(.center).define { flex in
            flex.addItem(self.movieSearchBar)
            flex.addItem(self.movieCollectionView).width(100%).height(100%).marginLeft(20).marginRight(20)
        }
    }
    
    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.itemSize = CGSize(width: 300, height: 50)
        return flowLayout
    }
}
