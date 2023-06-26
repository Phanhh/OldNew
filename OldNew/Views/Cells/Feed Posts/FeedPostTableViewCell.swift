//
//  FeedPostTableViewCell.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/02/18.
//

import UIKit

final class FeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "FeedPostTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
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
