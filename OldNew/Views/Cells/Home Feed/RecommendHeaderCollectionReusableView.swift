//
//  HeaderCollectionReusableView.swift
//  CompositionalLayout
//
//  Created by Phuong Anh Bui on 2023/06/02.
//

import UIKit

protocol RecommendHeaderCollectionReusableViewDelegate: AnyObject {
    func didTapSeeMoreRecommend()
}


final class RecommendHeaderCollectionReusableView: UICollectionReusableView {

    static let identifier = "RecommendHeaderCollectionReusableView"
    
    public weak var delegate:RecommendHeaderCollectionReusableViewDelegate?
    
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommend Products"
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
        delegate?.didTapSeeMoreRecommend()
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
