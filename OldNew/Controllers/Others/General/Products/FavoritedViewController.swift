//
//  FavoritedViewController.swift
//  CompositionalLayout
//
//  Created by Phuong Anh Bui on 2023/06/03.
//

import UIKit

class FavoritedViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoritedProductsTableViewCell.self, forCellReuseIdentifier: FavoritedProductsTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

}

extension FavoritedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritedProductsTableViewCell.identifier, for: indexPath) as! FavoritedProductsTableViewCell
        if indexPath.row % 3 != 0 {
            cell.configure(with: false)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ProductViewController()
        vc.title = "Post"
        if indexPath.row % 3 == 0 {
            vc.soldOrNot(with: true)
        } else {
            vc.soldOrNot(with: false)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
