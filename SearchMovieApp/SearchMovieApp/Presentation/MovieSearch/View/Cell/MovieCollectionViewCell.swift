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
    
    private let contanerView = UIView()
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
    
    // MARK: - func
    
    func setMovieTitle(to title: String) {
        self.movieTitle.text = title
    }
    
    func updateTitle(to title: String) {
        self.movieTitle.text = title
    }
    
    func updateOverView(to text: String) {
        self.overView.text = text
    }
    
    func updateImageView(to url: String) {
        self.posterImageView.load(url: url)
    }
    
    private func setupLayout() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
        self.addSubview(self.contanerView)
        
        self.contanerView.flex.direction(.row).justifyContent(.spaceBetween).define {
            $0.addItem().direction(.column).width(75%).define { flex in
                flex.addItem(self.movieTitle).marginBottom(10)
                flex.addItem(self.overView)
            }
            $0.addItem().direction(.column).width(20%).define { flex in
                flex.addItem(self.posterImageView).minWidth(70).aspectRatio(9/16)
            }
        }
    }
}

extension UIImageView {
    func load(url: String) {
        DispatchQueue.global().async { [weak self] in
            guard let fullUrl = URL(string: "https://image.tmdb.org/t/p/w154\(url)")  else { return }
            if let data = try? Data(contentsOf: fullUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
