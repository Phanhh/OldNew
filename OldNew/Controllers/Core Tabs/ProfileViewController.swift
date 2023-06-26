//
//  ProfileViewController.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/02/07.
//

import UIKit

// Profile View Controller

class ProfileViewController: UIViewController {

    private var collectionView: UICollectionView?
    var myInfor: Users?
    var productList = [Products]()
    var haveData = false
    
//    private var userPosts = [UserPost]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationItem.title = myInfor?.email
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let size = (view.width - 4)/3
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        layout.itemSize = CGSize(width: size, height: size)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = #colorLiteral(red: 0.9371551275, green: 0.6367940307, blue: 0.7333760858, alpha: 1)
        
        //Cell
        collectionView?.register(PhotoCollectionViewCell.self,
                                 forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        //Header
        collectionView?.register(ProfileInforHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInforHeaderCollectionReusableView.identifier)
        collectionView?.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
    
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(clearData), name: NSNotification.Name("ResetMyProductsNotification"), object: nil)
    }
    
    
    func getMyInformation(withAccessToken accessToken: String) {
        DatabaseManager.shared.getMyInfor(withAccessToken: accessToken) { (user, error) in
            if let error = error {
                print("Error retrieving user: \(error)")
            } else if let user = user {
                // Access the user object
                self.myInfor = user
                print(user.email)
                print(user.id)
            
            }
        }
        haveData = true
    }
    @objc func clearData(){
        productList.removeAll()
        myInfor = nil
        haveData = false
    }
    func loadData() {
        let accessToken = getAccessToken()
        getMyInformation(withAccessToken: accessToken!)
        DispatchQueue.main.async {
            DatabaseManager.shared.getProducts(withAccessToken: accessToken! , readAll: false) { result in
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
                        print("---")
                    }
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                }
            }
            self.collectionView?.reloadData()
        }
        haveData = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
    public func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingButton))
    }
    


    @objc private func didTapSettingButton(){
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc , animated: true)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        // return userPosts.count
        return productList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // let model = userPosts[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        let set = productList[indexPath.row].imageList[0]
        cell.configure(debug: set)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        //get the model and open post controller
        // let model = userPosts[indexPath.row]
        let vc = MyProductViewController()
        vc.title = "Post"
        vc.configure(with: productList[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            //footer
            return UICollectionReusableView()
        }
        if indexPath.section == 1 {
            //tab header
            let tabControlHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: ProfileTabsCollectionReusableView.identifier,
                                                                         for: indexPath) as! ProfileTabsCollectionReusableView
            tabControlHeader.delegate = self
            return tabControlHeader
        }
        
        let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: ProfileInforHeaderCollectionReusableView.identifier,
                                                                     for: indexPath) as! ProfileInforHeaderCollectionReusableView
        profileHeader.delegate = self
        profileHeader.configure(with: (UIImage(named: "avatar2"))!)
        return profileHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.width, height: collectionView.height/3)
        }
        //size of section tabs
        return CGSize(width: collectionView.width,
                      height: 50)
    }
}

extension ProfileViewController: ProfileInforHeaderCollectionReusableViewDelegate {
    func profileHeaderDidTapPostsButton(_ header: ProfileInforHeaderCollectionReusableView) {
        //0scroll to the posts
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    func profileHeaderDidTapFollowersButton(_ header: ProfileInforHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<3 {
            mockData.append(UserRelationship(username: "@phanh", name: "Phuong Anh", type: x%2==0 ? .following : .not_following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    func profileHeaderDidTapFollowingButton(_ header: ProfileInforHeaderCollectionReusableView) {
        var mockData = [UserRelationship]()
        for x in 0..<6 {
            mockData.append(UserRelationship(username: "@phanh", name: "Phuong Anh", type: x%3==0 ? .not_following : .following))
        }
        let vc = ListViewController(data: mockData)
        vc.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    func profileHeaderDidTapEditProfileButton(_ header: ProfileInforHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
}

extension ProfileViewController: ProfileTabsCollectionReusableViewDelegate {
    func didTapGridButtonTab() {
        // Reload collection view with data
    }
    func didTapTaggedButtonTab() {
        // Reload
    }
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    func didTapSaveChangeProfie(_ sender: Users) {
        // change avatar display
        self.myInfor = sender

    }
}
