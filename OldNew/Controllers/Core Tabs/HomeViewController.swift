//
//  ViewController.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/02/31.
//

import UIKit
import CoreData


class HomeViewController: UIViewController {
    
    var productList = [Products]() // list all products
    var favoritedProduct = [Products]() // list favorite products
    var haveData = false // load data or not
    var myInfor: Users? // store data of me
    var favoritedProductId = [Int]() // list favorited product id
    
    
    @IBOutlet weak var collectionView: UICollectionView! {
    didSet {
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
            collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavoritedHeaderCollectionReusableView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: FavoritedHeaderCollectionReusableView.identifier )
        collectionView.register(RecommendHeaderCollectionReusableView.self, forSupplementaryViewOfKind: "header", withReuseIdentifier: RecommendHeaderCollectionReusableView.identifier)
        }
    }
    
    func loadData() {
        let accessToken = getAccessToken()
        getMyInformation(withAccessToken: accessToken!)
        DatabaseManager.shared.getProducts(withAccessToken: accessToken! , readAll: true) { result in
            switch result {
            case .success(let parentObjects):
                // Access the array of User objects
                for parent in parentObjects {
                    var imageList = [UIImage]()
                    var variationList = [VariationReceive]()
                    for imageData in parent.imageList {
                        let image = UIImage(data: Data(base64Encoded: imageData)!)
                        imageList.append(image!)
                    }
                    for list in parent.variations {
                        variationList.append(list)
                    }
                    self.productList.append(Products(title: parent.title, description: parent.description, category: parent.category, shippingFee: parent.shippingFee, brand: parent.brand, shippingMethod: parent.shippingMethod, timeToShip: parent.timeToShip, departureRegion: parent.departureRegion, variation: variationList, imageList: imageList))
                    for i in self.favoritedProductId {
                        if parent.id == i {
                            self.favoritedProduct.append(Products(title: parent.title, description: parent.description, category: parent.category, shippingFee: parent.shippingFee, brand: parent.brand, shippingMethod: parent.shippingMethod, timeToShip: parent.timeToShip, departureRegion: parent.departureRegion, variation: variationList, imageList: imageList))
                        }
                    }
                    
                    print("---")
                }
            case .failure(let error):
                // Handle the error
                print("Error: \(error)")
            }
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func getMyInformation(withAccessToken accessToken: String) {
        DispatchQueue.main.async {
            DatabaseManager.shared.getMyInfor(withAccessToken: accessToken) { (user, error) in
                if let error = error {
                    print("Error retrieving user: \(error)")
                } else if let user = user {
                    // Access the user object
                    self.myInfor = user
                    for favorite in user.favoriteAssociations {
                        self.favoritedProductId.append(favorite.productId)
                    }
                                            
                    //                        print(favorite.userId)
                    //                        print(favorite.productId)
                    //                        print(favorite.isActive)
                    //                        print(favorite.id)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

//        let tabbar = tabBarController as! TabBarController
//        myInfor = tabbar.userMe
//        favoritedProductId = tabbar.favoritedId
        navigationItem.title = "OldNew"
        let notificationButton = UIBarButtonItem(
            image: UIImage(systemName: "bell"),
            style: .done,
            target: self,
            action: #selector(didTapOpenNotification))
        notificationButton.tintColor = .black
        navigationItem.rightBarButtonItem = notificationButton
        collectionView?.collectionViewLayout = createCompositionalLayout()
        NotificationCenter.default.addObserver(self, selector: #selector(clearData), name: NSNotification.Name("ResetMyInforNotification"), object: nil)

    }
    
    @objc func clearData() {
        productList.removeAll()
        favoritedProduct.removeAll()
        myInfor = nil
        favoritedProductId.removeAll()
        haveData = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !haveData {
            loadData()
            haveData = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    @objc private func didTapOpenNotification(){
        let vc = BuyingProcessViewController()
        vc.title = "Inprocessing"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout(sectionProvider: {[weak self](index, enviroment) -> NSCollectionLayoutSection? in
            return self?.createSectionFor(index: index, eviroment: enviroment)
        })
        return layout
    }
    
    func createSectionFor(index: Int, eviroment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch index {
        case 0:
            return createFirstSection()
        case 1:
            return createSecondSection()
        case 2:
            return createThirdSection()
        default:
            return createFirstSection()
        }
    }

    
    func createFirstSection()->NSCollectionLayoutSection {
        let inset = 2.5
        
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
    func createSecondSection()->NSCollectionLayoutSection {
        let inset = 2.5
        
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        // supplementary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(64))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        
        return section
    }
    
    func createThirdSection()->NSCollectionLayoutSection {
        let inset = 2.5
        
        // item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.15), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        // group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.15))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.accessibilityScroll(.down)
//        section.orthogonalScrollingBehavior = .none
        
        // supplementary
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(64))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        
        return section
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }

    

    
    private func handleNotAuthenticated(){
    
        // check auth status
        if let savedToken = getAccessToken() {
            print("Access Token: \(savedToken)")
//            loadData()
        } else {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
        // load data of my information after login
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return section == 2 ? 16 : 5
        switch section {
        case 0:
            return 3
        case 1:
            return favoritedProductId.count > 5 ? 5 : favoritedProductId.count
        default:
            return productList.count > 10 ? 10 : productList.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.section == 0 ){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
            switch indexPath.row {
            case 0:
                cell.configure(debug: UIImage(named: "banner1")!)
            case 1:
                cell.configure(debug: UIImage(named: "banner2")!)
            default:
                cell.configure(debug: UIImage(named: "banner3")!)
            }
            return cell
        }
        else if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
            let set = productList[indexPath.row].imageList[0]
            cell.configure(debug: set)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
            // cell.configure(with: model)
            let set = favoritedProduct[indexPath.row].imageList[0]
            cell.configure(debug: set)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: FavoritedHeaderCollectionReusableView.identifier, for: indexPath) as? FavoritedHeaderCollectionReusableView else {
                return UICollectionReusableView()
            }
            view.delegate = self
            return view
        } else {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: "header", withReuseIdentifier: RecommendHeaderCollectionReusableView.identifier, for: indexPath) as? RecommendHeaderCollectionReusableView else {
                return UICollectionReusableView()
            }
            view.delegate = self
            return view
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.section == 2) {
            let vc = ProductViewController()
            vc.title = "Post"
            vc.configure(with: productList[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 1 {
            let vc = ProductViewController()
            vc.title = "Post"
            vc.configure(with: favoritedProduct[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension HomeViewController: FavoritedHeaderCollectionReusableViewDelegate {
    func didTapSeeMoreFavorited() {
        let vc = FavoritedViewController()
        vc.title = "Favorited Products"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: RecommendHeaderCollectionReusableViewDelegate {
    func didTapSeeMoreRecommend(){
        let vc = ListProductsViewController()
        vc.title = "Recommend Products"
        navigationController?.pushViewController(vc, animated: true)
    }
}



