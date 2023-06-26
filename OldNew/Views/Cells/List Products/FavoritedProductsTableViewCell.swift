//
//  FavoritedProductsTableViewCell.swift
//  CompositionalLayout
//
//  Created by Phuong Anh Bui on 2023/06/05.
//

import UIKit


class FavoritedProductsTableViewCell: UITableViewCell {

    
    static let identifier = "FavoritedProductsTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Product 1"
        label.font.withSize(17)
        return label
    }()
    
    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar" )
        return imageView
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Sold"
        label.textColor = .white
        label.backgroundColor = .red
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "10000"
        label.font.withSize(15)
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        return button
    }()
//
//    public func configure(with model: ProductDetail) {
//
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(productImage)
        contentView.addSubview(statusLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(likeButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with sellStatus: Bool ){
        if sellStatus == false {
            statusLabel.removeFromSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size.height
        productImage.frame = CGRect(x: 0, y: 0, width: size, height: size)
        statusLabel.frame = CGRect(x: 0, y: productImage.bottom - 20, width: size, height: 20)
        nameLabel.frame = CGRect(x: productImage.right + 10, y: 10, width: contentView.frame.width/2, height: size/3)
        priceLabel.frame = CGRect(x: productImage.right + 10, y: nameLabel.bottom + 2, width: contentView.frame.size.width/2, height: size/3)
        likeButton.frame = CGRect(x: contentView.frame.width-50, y: size/2 - 10, width: 20, height: 20)
    }
}
