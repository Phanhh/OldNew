//
//  ProductViewController.swift
//  CompositionalLayout
//
//  Created by Phuong Anh Bui on 2023/06/09.
//

import UIKit

class ProductViewController: UIViewController {

    
    private var product: Products?
    
    private var status: Bool?
    private var variationChoice = -2
    private var myFavorited: Bool?
    var variationDisplay: [String] = []
    
    private let photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    //gan thong tin san pham
    public func configure(with product: Products){
        self.product = product
        itemName.text = product.title
        descriptionText.text = product.description
        categoryDetail.text = product.category
        shippingFeeDetail.text = product.shippingFee
        shippingMethodDetail.text = product.shippingMethod
        daysToShipDetail.text = product.timeToShip
        locationDetail.text = product.departureRegion
        for list in product.variation {
            var newVariation = "\(list.usageStatus)"
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
    // san pham da ban hay chua
    public func soldOrNot(with status: Bool){
        self.status = status
    }
    // product co phai favorited hay khong
    public func favoritedOrNot(with favorited: Bool){
        self.myFavorited = favorited
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myFavorited = false
        
        view.backgroundColor = .systemBackground
        
    }
    private func updateChoice() {
        switch variationChoice {
        case -1: // product sold out
            priceLabel.isHidden = true
            clickButton.isHidden = true
            buyButton.isHidden = true
            soldButton.isHidden = false
            quantityLabel.isHidden = true
            quantityStepper.isHidden = true
            quantity.isHidden = true
        case -2: // do not choose any variation
            priceLabel.isHidden = false
            clickButton.isHidden = false
            buyButton.isHidden = true
            soldButton.isHidden = false
            quantityLabel.isHidden = true
            quantityStepper.isHidden = true
            quantity.isHidden = true
            priceLabel.text = "1.000.000 - 1.200.000 VND"
        default: // when choose variation
            priceLabel.isHidden = false
            clickButton.isHidden = true
            buyButton.isHidden = false
            soldButton.isHidden = true
            quantityLabel.isHidden = false
            quantityStepper.isHidden = false
            quantity.isHidden = false
        }
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
            section.orthogonalScrollingBehavior = .paging
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
        label.textColor = .black
        label.backgroundColor = #colorLiteral(red: 0.9540140033, green: 0.9524665475, blue: 0.975907743, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bubble.middle.bottom"), for: .normal)
        button.tintColor = .link
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .link
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
        label.text = "Shipping fee"
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
        imageView.image = UIImage(named: "avatar")
        imageView.layer.cornerRadius = imageView.frame.height/2
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3.0
        imageView.clipsToBounds = true
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
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy now", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .red
        button.titleLabel?.textColor = .white
        return button
    }()
    
    private let clickButton: UIButton = {
        let button = UIButton()
        button.setTitle("Please choose variation", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .white
        button.setTitleColor(.red, for: .normal)
        button.layer.borderWidth = 0.25
        return button
    }()
    
    private let soldButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sold", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .lightGray
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let quantityStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.maximumValue = 5 // quantity of product
        stepper.stepValue = 1
        stepper.value = 1
        return stepper
    }()
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Quantity"
        label.font = UIFont.systemFont(ofSize: 17)
        label.backgroundColor = #colorLiteral(red: 0.9540140033, green: 0.9524665475, blue: 0.975907743, alpha: 1)
        return label
    }()
    private let quantity: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    @objc func updateQuantity() {
        quantity.text = "\(Int(quantityStepper.value))"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateChoice()
        
        let scrollView = UIScrollView(frame: view.bounds)
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.width, height: view.height*1.7)
        
        scrollView.addSubview(photoCollectionView)
        
        scrollView.addSubview(itemName)
//        scrollView.addSubview(priceLabel)
        scrollView.addSubview(likeButton)
        scrollView.addSubview(commentButton)
        scrollView.addSubview(shareButton)
        scrollView.addSubview(variationTableView)
        variationTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        variationTableView.delegate = self
        variationTableView.dataSource = self
    
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
        
        scrollView.superview?.insertSubview(priceLabel, at: .max)
        scrollView.superview?.insertSubview(quantity, at: .max)
        scrollView.superview?.insertSubview(quantityLabel, at: .max)
        scrollView.superview?.insertSubview(quantityStepper, at: .max)
        scrollView.superview?.insertSubview(soldButton, at: .max)
        scrollView.superview?.insertSubview(buyButton, at: .max)
        scrollView.superview?.insertSubview(clickButton, at: .max)
        
        quantity.text = "\(Int(quantityStepper.value))"
        
        priceLabel.frame = CGRect(x: 0, y: view.height-175, width: view.width, height: 40)
        quantityLabel.frame = CGRect(x: 20, y: view.height-210, width: view.width/2+35, height: 34)
        quantity.frame = CGRect(x: quantityLabel.right, y: view.height-210, width: 50, height: 34)
        quantityStepper.frame = CGRect(x: quantity.right, y: view.height-210, width: view.width/2-90, height: 40)
        buyButton.addTarget(self, action: #selector(didTapBuy), for: .touchUpInside)
        buyButton.frame = CGRect(x: 0, y: view.height-135, width: view.width, height: 50)
        
        soldButton.frame = CGRect(x: 0, y: view.height-135, width: view.width, height: 50)
        clickButton.frame = CGRect(x: 0, y: view.height-135, width: view.width, height: 50)
        
        photoCollectionView.collectionViewLayout = createCompositionalLayout()
        photoCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        photoCollectionView.dataSource = self
        photoCollectionView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height/3)
        
        commentButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        commentBoxButton.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
        quantityStepper.addTarget(self, action: #selector(updateQuantity), for: .valueChanged)
        
        itemName.frame = CGRect(x: 20, y: photoCollectionView.bottom+20, width: view.width-40, height: 30)
        
        likeButton.frame = CGRect(x: 20, y: itemName.bottom+10, width: 50, height: 50)
        commentButton.frame = CGRect(x: likeButton.right+5, y: itemName.bottom+10, width: 50, height: 50)
        shareButton.frame = CGRect(x: commentButton.right+5, y: itemName.bottom+10, width: 50, height: 50)
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
        

        likeButton.setImage(UIImage(systemName: myFavorited! ? "heart.fill" : "heart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        likeButton.tintColor = myFavorited! ? .red : .link
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
    }

    @objc private func didTapLikeButton() {
        switch myFavorited {
        case true:
            myFavorited = false
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .link
        case false:
            myFavorited = true
            likeButton.setImage(UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
            likeButton.tintColor = .red
        default:
            return
        }
    }
    @objc private func didTapComment(){
        let vc = CommentsViewController()
        vc.title = "Comments"
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func didTapBuy() {
        let vc = BuyConfirmViewController()
        vc.title = "Confirmation"
        variationChoice = -1
        updateChoice()
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
//        numberPhoto.text = "\(indexPath.row)/\(product?.imageList.count)"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        variationChoice = indexPath.row
//        priceLabel.text = product?.variation[indexPath.row].price
        updateChoice()
    
    }
}

