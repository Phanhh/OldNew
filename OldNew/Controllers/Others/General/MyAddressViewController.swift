//
//  YourAddressViewController.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/21.
//

import UIKit

class MyAddressViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let addButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .done,
            target: self,
            action: #selector(didTapAddAddress))
        addButton.tintColor = .link
        navigationItem.rightBarButtonItem = addButton
        view.backgroundColor = .systemBackground
        view.addSubview(noAddressIcon)
        view.addSubview(noAddressLabel)
        // Do any additional setup after loading the view.
    }
    

    @objc private func didTapAddAddress() {
        let vc = AddAddressViewController()
        vc.title = "Add New Address"
        navigationController?.pushViewController(vc, animated: true)
    }
  
    private let noAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "No address yet!"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    private let noAddressIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "house.and.flag")
        return imageView
    }()
    func noAddressDisplay() {
        noAddressIcon.frame = CGRect(x: (view.width-100)/2, y: view.height/2-100, width: 100, height: 100)
        noAddressLabel.frame = CGRect(x: 0, y: noAddressIcon.bottom, width: view.width, height: 50)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}
