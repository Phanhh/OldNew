//
//  BuyingProcessTableViewCell.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/13.
//

import UIKit

class BuyingProcessTableViewCell: UITableViewCell {

    static let identifier = "BuyingProcessTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Product 1"
        label.font.withSize(17)
        return label
    }()
    
    private let productImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "productPhoto1" )
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "10000"
        label.font.withSize(15)
        return label
    }()
    private let processLabel: UILabel = {
        let label = UILabel()
        label.text = "Prepare product"
        label.textColor = .gray
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
        return button
    }()
//
//    public func configure(with model: ProductDetail) {
//
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(productImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(processLabel)
        contentView.addSubview(nextButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.frame.size.height-10
        productImage.frame = CGRect(x: 0, y: 10, width: size, height: size)
        nameLabel.frame = CGRect(x: productImage.right + 10, y: 10, width: contentView.frame.width/2, height: size/3)
        priceLabel.frame = CGRect(x: productImage.right + 10, y: nameLabel.bottom, width: contentView.frame.size.width/2, height: size/3)
        processLabel.frame = CGRect(x: productImage.right + 10, y: priceLabel.bottom, width: contentView.frame.size.width/2, height: size/3-10)
        nextButton.frame = CGRect(x: contentView.frame.width-size-10, y: 0, width: size, height: size)
    }
}
