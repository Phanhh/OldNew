//
//  BuyingProcessViewController.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/13.
//

import UIKit

class BuyingProcessViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BuyingProcessTableViewCell.self, forCellReuseIdentifier: BuyingProcessTableViewCell.identifier)
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

extension BuyingProcessViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BuyingProcessTableViewCell.identifier, for: indexPath)

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BuyingViewController()
        vc.title = "Buy Process"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


