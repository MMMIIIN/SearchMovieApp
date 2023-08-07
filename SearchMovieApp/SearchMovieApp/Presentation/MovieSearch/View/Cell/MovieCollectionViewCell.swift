//
//  MovieCollectionViewCell.swift
//  SearchMovieApp
//
//  Created by Mingwan Choi on 2023/07/24.
//

import FlexLayout
import PinLayout

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - ui component
    
    private let contanerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    private let movieTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .font(size: 18)
        return label
    }()
    private let releaseData: UILabel = {
        let label = UILabel()
        label.font = .font(size: 14)
        label.textColor = .systemGray2
        return label
    }()
    private let overView: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.font = .font(size: 16)
        return label
    }()
    private let voteArange: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = .font(size: 14)
        return label
    }()
    private let posterImageView = UIImageView()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override
    
    override func layoutSubviews() {
        self.contanerView.pin.all()
        self.contanerView.flex.layout()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        self.contanerView.bounds.size.width = size.width
        self.contanerView.flex.layout(mode: .adjustHeight)
        return self.contanerView.frame.size
    }
    
    override func prepareForReuse() {
        self.posterImageView.image = nil
    }
    
    // MARK: - func
    
    func updateTitle(to title: String) {
        self.movieTitle.text = title
    }
    
    func updateReleaseDate(to date: String) {
        self.releaseData.text = "개봉일 : \(date)"
    }
    
    func updateOverView(to text: String) {
        self.overView.text = text
    }
    
    func updateVoteArange(to arange: Double) {
        self.voteArange.text = "평점 \(arange.description)"
    }
    
    func updateImageView(to url: String) {
        self.posterImageView.load(url: url)
    }
    
    private func setupLayout() {
        self.addSubview(self.contanerView)
        
        self.contanerView.flex.direction(.row).padding(12).justifyContent(.spaceBetween).define {
            $0.addItem().direction(.column).maxWidth(80%).define { flex in
                flex.addItem(self.movieTitle).marginBottom(4)
                flex.addItem(self.releaseData).marginBottom(4)
                flex.addItem(self.overView).marginBottom(12)
                flex.addItem(self.voteArange)
            }
            $0.addItem().direction(.column).minWidth(20%).define { flex in
                flex.addItem(self.posterImageView).minWidth(70).aspectRatio(9/16)
            }
        }
    }
}
