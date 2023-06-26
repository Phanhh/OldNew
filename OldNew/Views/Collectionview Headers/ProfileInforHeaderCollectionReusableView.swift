//
//  CollectionReusableView.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/04/18.
//

import UIKit

protocol ProfileInforHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInforHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInforHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInforHeaderCollectionReusableView)
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInforHeaderCollectionReusableView)
}

final class ProfileInforHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileInforHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInforHeaderCollectionReusableViewDelegate?
    private let profilePhotoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar")
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3.0
        imageView.clipsToBounds = true
        return imageView
    }()
    private let postButton: UIButton = {
       let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    private let followersButton: UIButton = {
       let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    private let followingButton: UIButton = {
       let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Reviews"
        label.textColor = .systemBlue
        return label
    }()
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Your Profile", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Phuong Anh Bui"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "This is the first account!"
        label.textColor = .label
        label.numberOfLines = 0 // line wrap
        return label
    }()
    
    // MARK: - Init
    public func configure(with avatar: UIImage){
        self.profilePhotoImageView.image = avatar
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubviews()
        addButtonActions()
        backgroundColor = .systemBackground
        clipsToBounds = true
    }
    
    private func addSubviews() {
        addSubview(profilePhotoImageView)
        addSubview(postButton)
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(nameLabel)
        addSubview(ratingLabel)
        addSubview(bioLabel)
        addSubview(editProfileButton)
    }
    
    private func addButtonActions() {
        followersButton.addTarget(self, action: #selector(didTapFollowersButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didTapFollowingButton), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(didTapPostsButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didTapEditProfileButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(x: 5, y: 5, width: profilePhotoSize, height: profilePhotoSize).integral
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        let buttonHeight = profilePhotoSize/2
        let countButonWidth = (width-10-profilePhotoSize)/3
        postButton.frame = CGRect(x: profilePhotoImageView.right, y: 5, width: countButonWidth, height: buttonHeight).integral
        followersButton.frame = CGRect(x: postButton.right, y: 5, width: countButonWidth, height: buttonHeight).integral
        followingButton.frame = CGRect(x: followersButton.right, y: 5, width: countButonWidth, height: buttonHeight).integral
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right, y: 5 + buttonHeight, width: countButonWidth*3, height: buttonHeight).integral
        nameLabel.frame = CGRect(x: 5 , y: 5 + profilePhotoImageView.bottom, width: width-10, height: 50).integral
        ratingLabel.frame = CGRect(x: 5 , y: nameLabel.bottom, width: width-10, height: 50).integral
        let bioLabelSize = bioLabel.sizeThatFits(frame.size)
        bioLabel.frame = CGRect(x: 5 , y: 5+ratingLabel.bottom, width: width-10, height: bioLabelSize.height).integral

    }
    
    // MARK: - Actions
    @objc private func didTapFollowersButton() {
        delegate?.profileHeaderDidTapFollowersButton(self)
    }
    @objc private func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)
    }
    @objc private func didTapPostsButton() {
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    @objc private func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditProfileButton(self)
    }
}
