//
//  BuyConfirmViewController.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/13.
//

import UIKit

class BuyConfirmViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dismissButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .done,
            target: self,
            action: #selector(didTapClose))
        dismissButton.tintColor = .black
        navigationItem.leftBarButtonItem = dismissButton
        
        view.backgroundColor = .systemBackground
        view.addSubview(productCover)
        view.addSubview(productName)
        view.addSubview(priceLabel)
        view.addSubview(couponLable)
        view.addSubview(couponButton)
        view.addSubview(paymentMethodLabel)
        view.addSubview(paymentMethodButton)
        view.addSubview(totalPayLabel)
        view.addSubview(totalPayDetail)
        view.addSubview(shippingAddressLabel)
        view.addSubview(shippingAddressButton)
        view.addSubview(buyButton)
        
        buyButton.addTarget(self, action: #selector(didTapBuyProduct), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    @objc func didTapClose() {
        dismiss(animated: true)
    }
    @objc func didTapBuyProduct() {
        var dialogMessage = UIAlertController(title: "Product purchased successfully!!!", message: "", preferredStyle: .alert)
        // Create OK button with action handler
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            self.dismiss(animated: true)
        }
        dialogMessage.addAction(cancel)
        self.present(dialogMessage, animated: true, completion: nil)
    }

    private let productCover: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "productPhoto1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let productName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Product Name"
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "1000000"
        return label
    }()
    
    private let couponLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Coupon"
        return label
    }()
    private let couponButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName:"chevron.right"), for: .normal)
        button.setTitle("required", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 17)
        return button
    }()
    private let paymentMethodLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Payment method"
        return label
    }()
    private let paymentMethodButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName:"chevron.right"), for: .normal)
        button.setTitle("required", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 17)
        return button
    }()
    private let totalPayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.text = "Amount to be paid"
        return label
    }()
    private let totalPayDetail: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "1000000"
        return label
    }()
    
    private let shippingAddressLabel: UILabel = {
        let label = UILabel()
        label.text = "Shipping address"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    private let shippingAddressButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName:"chevron.right"), for: .normal)
        button.setTitle("required", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 17)
        return button
    }()
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy now", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .red
        button.titleLabel?.textColor = .white
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        productCover.frame = CGRect(x: 20, y: 60, width: 100, height: 100)
        productName.frame = CGRect(x: productCover.right+10, y: 70, width: view.width/2, height: 20)
        priceLabel.frame = CGRect(x: productCover.right+10, y: productName.bottom+5, width: view.width/2, height: 20)
        
        couponLable.frame = CGRect(x: 20, y: productCover.bottom + 15, width: view.width/2, height: 30)
        couponButton.frame = CGRect(x: couponLable.right, y: productCover.bottom + 15, width: view.width-view.width/2-40, height: 30)
        
        paymentMethodLabel.frame = CGRect(x: 20, y: couponLable.bottom + 15, width: view.width/2, height: 30)
        paymentMethodButton.frame = CGRect(x: paymentMethodLabel.right, y: couponLable.bottom + 15, width: view.width-view.width/2-40, height: 30)
        
        totalPayLabel.frame = CGRect(x: 20, y: paymentMethodLabel.bottom + 15, width: view.width/2, height: 30)
        totalPayDetail.frame = CGRect(x: totalPayLabel.right, y: paymentMethodLabel.bottom + 15, width: view.width-view.width/2-40, height: 30)
        
        shippingAddressLabel.frame = CGRect(x: 20, y: totalPayLabel.bottom + 15, width: view.width/2, height: 60)
        shippingAddressButton.frame = CGRect(x: shippingAddressLabel.right, y: totalPayLabel.bottom + 15, width: view.width-view.width/2-40, height: 60)
        
        buyButton.frame = CGRect(x: 20, y: shippingAddressLabel.bottom + 20, width: view.width-40, height: 50)
    }
}
