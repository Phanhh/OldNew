//
//  ListCollectionViewCell.swift
//  CompositionalLayout
//
//  Created by Phuong Anh Bui on 2023/06/05.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ListCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.textColor = .white
        label.text = "1000000VND"
        label.font.withSize(3)
        label.textAlignment = .center
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        priceLabel.frame = CGRect(x:0, y: imageView.bottom - 20, width: contentView.width, height: 20)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .orange
        contentView.addSubview(imageView)
        contentView.addSubview(priceLabel)
        let images = [
            UIImage(named: "camera1"),
            UIImage(named: "camera2"),
            UIImage(named: "camera3"),
            UIImage(named: "camera4"),
        ].compactMap({$0})
        imageView.image = images.randomElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
