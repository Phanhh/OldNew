//
//  FavoritedCollectionReusableView.swift
//  CompositionalLayout
//
//  Created by Phuong Anh Bui on 2023/06/05.
//

import UIKit

protocol FavoritedHeaderCollectionReusableViewDelegate: AnyObject {
    func didTapSeeMoreFavorited()
}


final class FavoritedHeaderCollectionReusableView: UICollectionReusableView {

    static let identifier = "FavoritedHeaderCollectionReusableView"
    
    public weak var delegate:FavoritedHeaderCollectionReusableViewDelegate?
    
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorited Products"
        return label
    }()
    
    private let seeMoreButton: UIButton = {
        let button = UIButton()
        button.setTitle("See More", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font.withSize(12)
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textLabel)
        addSubview(seeMoreButton)
        seeMoreButton.addTarget(self, action: #selector(didTapSeeMore), for: .touchUpInside)
    }
    
    
    @objc private func didTapSeeMore() {
        delegate?.didTapSeeMoreFavorited()
    }
    public func configureLabel(with nameLabel: String?){
        textLabel.text = nameLabel
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = CGRect(x: 3, y: 3, width:width, height: height)
        seeMoreButton.frame = CGRect(x: width/2, y: 3, width: width/2-5, height: height)
        seeMoreButton.contentHorizontalAlignment = .right
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

