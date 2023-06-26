//
//  MyProductViewController.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/13.
//

import UIKit

class MyProductViewController: UIViewController {

    static let identifier = "MyProductViewController"
    
    private var product: Products? // data from received
    var productUpload: ProductUpload?
    
    private var variationChoice = 0
    var variationDisplay: [String] = []
    private let photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    public func configure(with product: Products){
        self.product = product
        itemName.text = product.title
//        descriptionText.text = product.description
        descriptionText.text = "\(getAccessToken())"
        categoryDetail.text = product.category
        shippingFeeDetail.text = product.shippingFee
        shippingMethodDetail.text = product.shippingMethod
        daysToShipDetail.text = product.timeToShip
        locationDetail.text = product.departureRegion
        for list in product.variation {
            var newVariation = "\(list.usageStatus) : \(list.quantity): \(list.price)VND"
            if !list.size.isEmpty {
                newVariation = "\(list.size), " + newVariation
            }
            if !list.name.isEmpty {
                newVariation = "\(list.name), " + newVariation
            }
            if !list.color.isEmpty {
                newVariation = "\(list.color), " + newVariation
            }
            variationDisplay.append(newVariation)
            print("Product variation: \(newVariation)")
        }
        DispatchQueue.main.async {
            self.variationTableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let imageArr = [ UIImage(named: "productPhoto1"),
                         UIImage(named: "productPhoto2"),
                         UIImage(named: "productPhoto3"),
                         UIImage(named: "productPhoto4"),
                         UIImage(named: "productPhoto5")
        ]
        
    }

    private func createCompositionalLayout() -> UICollectionViewLayout {
            let layouts = UICollectionViewCompositionalLayout.init { sectionIndex, environment in
                self.horizontalSection()
            }
            return layouts
    }
        
    private func horizontalSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                  heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 0
        section.orthogonalScrollingBehavior = .groupPagingCentered
            return section
    }
    

    private let variationTableView: UITableView = {
        let tableview = UITableView()
        return tableview
    }()

    private let itemName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "1000000VND - 1200000VND"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bubble.middle.bottom"), for: .normal)
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        return button
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Product Description"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    private let descriptionText: UITextView = {
        let field = UITextView()
        field.font = UIFont.systemFont(ofSize: 17)
        field.text = "This is a new product"
        field.isScrollEnabled = false
        field.backgroundColor = .secondarySystemBackground
        field.isEditable = false
        field.textColor = .black
        return field
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Product Information"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    private let categoryDetail: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .darkGray
        label.textAlignment = .right
        return label
    }()

    private let shippingFeeLabel: UILabel = {
        let label = UILabel()
        label.text = "Shipping fee pay by"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    private let shippingFeeDetail: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .darkGray
        label.textAlignment = .right
        return label
    }()
    private let shippingMethodLabel: UILabel = {
        let label = UILabel()
        label.text = "Shipping method"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    private let shippingMethodDetail: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .darkGray
        label.textAlignment = .right
        return label
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Shipping from"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    private let locationDetail: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .darkGray
        label.textAlignment = .right
        return label
    }()
    private let daysToShipLabel: UILabel = {
        let label = UILabel()
        label.text = "Days to ship"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    private let daysToShipDetail: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .darkGray
        label.textAlignment = .right
        return label
    }()
    private let sellerDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "Seller Information"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    private let avatarPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .purple
        return imageView
    }()
    private let sellerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "@phuonganhbui"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "✩✩✩✩✩"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Comments"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.textAlignment = .left
        return label
    }()
    private let commentBoxButton: UIButton = {
        let button = UIButton()
        button.setTitle("Comments", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 0.25
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private let editPostButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit post", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .white
        button.setTitleColor(.red, for: .normal)
        button.layer.borderWidth = 0.25
        return button
    }()
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let scrollView = UIScrollView(frame: view.bounds)
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.width, height: view.height*1.7)
        
        scrollView.addSubview(photoCollectionView)

        scrollView.addSubview(itemName)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(likeButton)
        scrollView.addSubview(commentButton)
        scrollView.addSubview(shareButton)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(descriptionText)
        scrollView.addSubview(detailLabel)
        scrollView.addSubview(categoryLabel)
        scrollView.addSubview(categoryDetail)

        scrollView.addSubview(shippingFeeLabel)
        scrollView.addSubview(shippingFeeDetail)
        scrollView.addSubview(shippingMethodLabel)
        scrollView.addSubview(shippingMethodDetail)
        scrollView.addSubview(locationLabel)
        scrollView.addSubview(locationDetail)
        scrollView.addSubview(daysToShipLabel)
        scrollView.addSubview(daysToShipDetail)
        scrollView.addSubview(sellerDetailLabel)
        scrollView.addSubview(avatarPhoto)
        scrollView.addSubview(sellerNameLabel)
        scrollView.addSubview(ratingLabel)
        scrollView.addSubview(commentLabel)
        scrollView.addSubview(commentBoxButton)
        scrollView.addSubview(variationTableView)
        
        scrollView.superview?.insertSubview(editPostButton, at: .max)
        
        variationTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        variationTableView.delegate = self
        variationTableView.dataSource = self
        
        editPostButton.addTarget(self, action: #selector(didTapEditPost), for: .touchUpInside)
        
        photoCollectionView.collectionViewLayout = createCompositionalLayout()
        photoCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        photoCollectionView.dataSource = self
        
        commentButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        commentBoxButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        
        photoCollectionView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/3)
        
        itemName.frame = CGRect(x: 20, y: photoCollectionView.bottom+20, width: view.width-40, height: 30)
        priceLabel.frame = CGRect(x: 20, y: itemName.bottom+10, width: view.width-40, height: 30)
        likeButton.frame = CGRect(x: 20, y: priceLabel.bottom+10, width: 30, height: 30)
        commentButton.frame = CGRect(x: likeButton.right+5, y: priceLabel.bottom+10, width: 30, height: 30)
        shareButton.frame = CGRect(x: commentButton.right+5, y: priceLabel.bottom+10, width: 30, height: 30)
        variationTableView.frame = CGRect(x: 20, y: likeButton.bottom + 5, width: view.width-40, height: 60)
        descriptionLabel.frame = CGRect(x: 20, y: variationTableView.bottom + 15, width: view.width-40, height: 30)
        descriptionText.frame = CGRect(x: 20, y: descriptionLabel.bottom+5, width: view.width-40, height: 400)
        
        detailLabel.frame = CGRect(x: 20, y: descriptionText.bottom+15, width: view.width-40, height: 30)
        categoryLabel.frame = CGRect(x: 20, y: detailLabel.bottom+10, width: view.width/3, height: 30)
        categoryDetail.frame = CGRect(x: view.width/3+30, y: detailLabel.bottom+10, width: view.width/2, height: 30)
        
        shippingFeeLabel.frame = CGRect(x: 20, y: categoryLabel.bottom+5, width: view.width/3, height: 30)
        shippingFeeDetail.frame = CGRect(x: view.width/3+30, y: categoryLabel.bottom+5, width: view.width/2, height: 30)
        shippingMethodLabel.frame = CGRect(x: 20, y: shippingFeeLabel.bottom+5, width: view.width/3, height: 30)
        shippingMethodDetail.frame = CGRect(x: view.width/3+30, y: shippingFeeLabel.bottom+5, width: view.width/2, height: 30)
        locationLabel.frame = CGRect(x: 20, y: shippingMethodLabel.bottom+5, width: view.width/3, height: 30)
        locationDetail.frame = CGRect(x: view.width/3+30, y: shippingMethodLabel.bottom+5, width: view.width/2, height: 30)
        daysToShipLabel.frame = CGRect(x: 20, y: locationLabel.bottom+5, width: view.width/3, height: 30)
        daysToShipDetail.frame = CGRect(x: view.width/3+30, y: locationLabel.bottom+5, width: view.width/2, height: 30)
        
        sellerDetailLabel.frame = CGRect(x: 20, y: daysToShipLabel.bottom+15, width: view.width-40, height: 30)
        avatarPhoto.frame = CGRect(x: 20, y: sellerDetailLabel.bottom+10 , width: 60, height: 60)
        sellerNameLabel.frame = CGRect(x: avatarPhoto.right + 10, y: sellerDetailLabel.bottom+10, width: view.width-100, height: 30)
        ratingLabel.frame = CGRect(x: avatarPhoto.right + 10, y: sellerNameLabel.bottom, width: view.width-100, height: 30)
        commentLabel.frame = CGRect(x: 20, y: avatarPhoto.bottom+15, width: view.width-40, height: 30)
        commentBoxButton.frame = CGRect(x: 20, y: commentLabel.bottom+10, width: view.width-40, height: 50)
        editPostButton.frame = CGRect(x: 20, y: view.height-135, width: view.width-40, height: 50)
    }

    @objc private func didTapEditPost() {
        let actionSheet = UIAlertController(title: "",
                                            message: "",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Edit post", style: .default, handler: { _ in
            // show add product with properties of this product
            let vc = AddProductViewController()
            vc.configure(with: .draft)
            vc.editPost(with: self.product!)
            vc.title = "Sell an item"
            self.present(UINavigationController(rootViewController: vc) , animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Delete post", style: .destructive, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionSheet, animated: true)
    }

    
    @objc private func didTapComment(){
//        let vc = CommentsViewController()
//        vc.title = "Comments"
//        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyProductViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product?.imageList.count ?? 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageView = UIImageView()
        cell.addSubview(imageView)
        imageView.frame = cell.bounds
        imageView.contentMode = .scaleAspectFit
        imageView.image = product?.imageList[indexPath.row]
//        if(indexPath.row == 0) {
//            imageView.image = UIImage(named: "productPhoto1")
//            numberPhoto.text = "\(indexPath.row+1)/5"
//        }
//        else if(indexPath.row == 1){
//            imageView.image = UIImage(named: "productPhoto2")
//            numberPhoto.text = "\(indexPath.row)/5"
//        }
//        else if(indexPath.row == 2){
//            imageView.image = UIImage(named: "productPhoto3")
//            numberPhoto.text = "\(indexPath.row)/5"
//        }
//        else if(indexPath.row == 3){
//            imageView.image = UIImage(named: "productPhoto4")
//            numberPhoto.text = "\(indexPath.row)/5"
//        }
//        else {
//            imageView.image = UIImage(named: "productPhoto5")
//            numberPhoto.text = "\(indexPath.row+1)/5"
//        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
}

extension MyProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product?.variation.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = variationDisplay[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
}
