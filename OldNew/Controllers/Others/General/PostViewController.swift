//
//  PostViewController.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/02/07.
//

import UIKit

/// States of a rendered cell

enum PostRenderType {
    case header(provider: User)
    case primaryContent(provider: UserPost)
    case actions(provider: String)
    case comments(comments: [PostComment])
}
/// Model of rendered post
struct PostRenderViewModel {
    let renderType: PostRenderType
}

class PostViewController: UIViewController {

    private let model: UserPost?
    
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        // register view
        tableView.register(FeedPostTableViewCell.self,
                           forCellReuseIdentifier: FeedPostTableViewCell.identifier)
        tableView.register(FeedPostHeaderTableViewCell.self,
                           forCellReuseIdentifier: FeedPostHeaderTableViewCell.identifier)
        tableView.register(FeedPostActionTableViewCell.self,
                           forCellReuseIdentifier: FeedPostActionTableViewCell.identifier)
        tableView.register(FeedPostGeneralTableViewCell.self,
                           forCellReuseIdentifier: FeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Init
    
    
    init(model: UserPost?){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    private func configureModels() {
        guard let userPostModel = self.model else {
            return
        }
        // Header
        renderModels.append(PostRenderViewModel.init(renderType: .header(provider: userPostModel.owner)))
        // Content
        renderModels.append(PostRenderViewModel.init(renderType: .primaryContent(provider: userPostModel)))
        // Action
        renderModels.append(PostRenderViewModel.init(renderType: .actions(provider: "")))
        // Comments
        var comments = [PostComment]()
        for x in 0...5 {
            comments.append(PostComment.init(identifier: "test_\(x)",
                                             username: "@test\(x)",
                                             comment: "This is a comment.",
                                             createdDate: Date()))
        }
        renderModels.append(PostRenderViewModel.init(renderType: .comments(comments: comments)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    - Header model
     - Post Cell model
     - Action Button Cell model
     - n Number of general models for comments
     
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}


extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .actions(_): return 1
        case .comments(let comments): return comments.count > 4 ? 4 : comments.count
        case .primaryContent(_): return 1
        case .header(_): return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .actions(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostActionTableViewCell.identifier, for: indexPath) as! FeedPostActionTableViewCell
            return cell
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostGeneralTableViewCell.identifier, for: indexPath) as! FeedPostGeneralTableViewCell
            return cell
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostTableViewCell.identifier, for: indexPath) as! FeedPostTableViewCell
            return cell
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: FeedPostHeaderTableViewCell.identifier, for: indexPath) as! FeedPostHeaderTableViewCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .actions(_):
            return 60
        case .comments(_):
            return 50
        case .primaryContent(_):
            return tableView.width
        case .header(_):
            return 70
        }
    }
}
