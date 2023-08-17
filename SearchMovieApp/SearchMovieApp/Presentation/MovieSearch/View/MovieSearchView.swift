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
        searchBar.searchTextField.accessibilityIdentifier = AccessibilityIdentifier.movieSearchBarTextField
        return searchBar
    }()
    private lazy var movieCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    // MARK: - init
    
    override init (frame: CGRect) {
        super.init(frame: .zero)
        self.setupLayout()
        self.configureUI()
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
    
    private func configureUI() {
        self.backgroundColor = .white
    }
    
    func collectionView() -> UICollectionView {
        return self.movieCollectionView
    }
    
    func searchBar() -> UISearchBar {
        return self.movieSearchBar
    }
    
    private func setupLayout() {
        self.addSubview(flexContainerView)
        
        self.flexContainerView.flex.direction(.column).alignItems(.center).define { flex in
            flex.addItem(self.movieSearchBar)
            flex.addItem(self.movieCollectionView).width(100%).height(100%).marginLeft(20).marginRight(20)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(10)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(1)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20)
        section.interGroupSpacing = 20

        return UICollectionViewCompositionalLayout(section: section)
    }
}
