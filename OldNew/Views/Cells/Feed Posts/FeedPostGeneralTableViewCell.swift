//
//  FeedPostGeneralTableViewCell.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/04/18.
//

import UIKit

class FeedPostGeneralTableViewCell: UITableViewCell {
    // Comments

    static let identifier = "FeedPostGeneralTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemOrange
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
