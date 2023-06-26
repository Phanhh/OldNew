//
//  CommentsViewController.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/13.
//

import UIKit

class CommentsViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    private let commentTextField: UITextField = {
        let field = UITextField()
        field.textColor = .black
        field.backgroundColor = .white
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 0.25
        field.placeholder = "Enter your comment..."
        field.textAlignment = .left
//        field.lineBreakMode = .byWordWrapping
        return field
    }()
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(tableView)
        view.addSubview(commentTextField)
        view.addSubview(sendButton)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        commentTextField.frame = CGRect(x: 10, y: view.bottom - 150, width: view.width-100, height: 50)
        sendButton.frame = CGRect(x: commentTextField.right, y: view.bottom-150, width: 80, height: 50)
    }
    


}
