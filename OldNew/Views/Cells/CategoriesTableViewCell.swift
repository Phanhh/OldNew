//
//  CategoriesTableViewCell.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/05/29.
//

import UIKit


class CategoriesTableViewCell: UITableViewCell {
    
    static let identifier = "CategoriesTableViewCell"

    private var model: Category?
    
    public let imagePhoto: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = #colorLiteral(red: 0.2685508132, green: 0.6802952886, blue: 1, alpha: 1)
        image.image = UIImage(named: "Image1")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    public let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.text = "Catagory Name"
        label.layer.masksToBounds = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(imagePhoto)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: Category){
        self.model = model
        imagePhoto.image = UIImage(named: model.imagePhoto)
        label.text = model.name
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imagePhoto.image = nil
        label.text = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        imagePhoto.frame = CGRect(x: 25, y: 10, width: 80, height: 80)
        label.frame = CGRect(x:150 , y: 25, width: contentView.frame.width, height: contentView.frame.height/2)
    }
}

