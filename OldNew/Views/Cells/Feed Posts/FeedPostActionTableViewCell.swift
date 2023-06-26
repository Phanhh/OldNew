//
//  FeedPostActionTableViewCell.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/02/18.
//

import UIKit

class FeedPostActionTableViewCell: UITableViewCell {

    static let identifier = "FeedPostActionTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        //configure the cell
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

}
