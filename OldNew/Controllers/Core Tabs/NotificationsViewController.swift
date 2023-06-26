//
//  NotificationsViewController.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/02/07.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var noNotificationsView = NoNotificationsView()
    
    private var models = [UserNotification]()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        navigationItem.title = "Notifications"
        view.backgroundColor  = .systemBackground
        view.addSubview(spinner)
        //spinner.startAnimating()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    private func fetchNotifications() {
        for x in 0...100 {
            let user = User(imagePhoto: UIImage(named: "avatar")!,
                            name: "Test",
                            username: "test123",
                            bio: "This is my bio",
                            email: "test@gmail.com",
                            phonenumber: "092381244",
                            gender: .female,
                            counts: UserCount(posts: 2),
                            joinDate: Date())
            let post = UserPost(identifier: "",
                                postType: .photo,
                                thumbnailImage: URL(string: "https://images.pexels.com/photos/850359/pexels-photo-850359.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")!,
                                postURL: URL(string: "https://images.pexels.com/photos/850359/pexels-photo-850359.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")!,
                                caption: nil,
                                lineCount: [],
                                comments: [],
                                createdDate: Date(),
                                taggedUsers: [],
                                owner: user)
            let model = UserNotification(type: x%2==0 ? .like(post: post ) : .follow(state: .not_following),
                                         text: "This is test notification.",
                                         user: user)
            models.append(model)
        }
    }
    
    private func addNoNotificationsView(){
        tableView.isHidden = true
        view.addSubview(tableView)
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/2)
        noNotificationsView.center = view.center
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            // like cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            // follow cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
         //   cell.configure(with: model)
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        switch model.type {
        case .like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(_):
            fatalError("Dev Issue: Should never get called")
        }
        // open the post
        
    }
}

extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
    func didTapFollowUnfollowButton(model: UserNotification) {
        print("Tapped")
        // perform database update
    }
}
