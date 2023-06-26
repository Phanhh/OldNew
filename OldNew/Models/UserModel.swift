//
//  Models.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/05/18.
//

import UIKit

enum Gender {
    case male, female, other
}

struct User {
    let imagePhoto: UIImage
    let name: String?
    let username: String?
    let bio: String?
    let email: String?
    let phonenumber: String?
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let posts: Int
}

public enum UserPostType: String {
    case photo = "Photo"
    case video = "Video"
}

public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL //video
    let caption: String?
    let lineCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUsers: [String]
    let owner: User
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let comment: String
    let createdDate: Date
}
