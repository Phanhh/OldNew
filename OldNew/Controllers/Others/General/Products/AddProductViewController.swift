//
//  AddProductViewController.swift
//  CompositionalLayout
//
//  Created by Phuong Anh Bui on 2023/06/07.
//

import UIKit
import PhotosUI

enum PhotoPickerType {
    case byCamera, byLibrary, draft
}

class AddProductViewController: UIViewController {
    
    private var pickedtype: PhotoPickerType = .byCamera
    private var multipleVariation = false
    
    var imageArr = [UIImage]()
    var variationArr = [String]()
    var listVariation = [Variations]()
    
    private var product: Products?
    var productUpload: ProductUpload?

    let arrProvince = ProvinceVN.all()
    // truyen vao khi edit
    public func editPost(with data: Products){
        self.product = data
        nameTextField.text = product?.title
        descriptionTextField.text = product?.description
        categoryButton.titleLabel?.text = product?.category
        shippingFeeButton.titleLabel?.text = product?.shippingFee
        shippingTimeButton.titleLabel?.text = product?.timeToShip
        shippingMethodButton.titleLabel?.text = product?.shippingMethod
        shippingStartRegionButton.titleLabel?.text = product?.departureRegion
        imageArr = product!.imageList
        if let product = product {
            for variation in product.variation {
                let newVariation = Variations(
                    name: variation.name,
                    color: variation.color,
                    size: variation.size,
                    usageStatus: variation.usageStatus,
                    quantity: variation.quantity,
                    price: variation.price,
                    isSold: variation.isSold
                )
                listVariation.append(newVariation)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateVariation()

        
        let dismissButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .done,
            target: self,
            action: #selector(didTapClose))
        dismissButton.tintColor = .black
        navigationItem.leftBarButtonItem = dismissButton
        view.backgroundColor = .systemBackground
        
        quantityTextField.delegate = self
        nameTextField.delegate = self
        descriptionTextField.delegate = self
        priceTextField.delegate = self
        
        switch pickedtype {
        case .byCamera:
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            present(picker, animated: true)
        case .byLibrary:
            var config = PHPickerConfiguration(photoLibrary: .shared())
            config.selectionLimit = 5
            config.filter = .images
            let vc = PHPickerViewController(configuration: config)
            vc.delegate = self
            present(vc, animated: true)
        case .draft:
            return
        }
        
//        product = Product(imageList: nil, name: nameTextField.text, description: description, categoryName: categoryButton.titleLabel ,usageStatus: .newUnused, quantity: quantityTextField, shippingFee: .byBuyer, shippingMethod: shippingMethodButton.titleLabel, timeToShip: .oneToTwo, departureRegion: ProvinceVN, price: priceTextField, sellerID: 1, is_sold: false)
        
        // Do any additional setup after loading the view.
//        JSONEncoder bien model thanh message
//        networkcontrolwer de send post request len API va nhan ve ket qua
    }
    
    private func updateVariation() {
        if multipleVariation { // multiple variation
            addVariationButton.isHidden = false
            tableView.isHidden = false
            label3.isHidden = true
            usageStatusButton.isHidden = true
            quantityLabel.isHidden = true
            quantityTextField.isHidden = true
            colorLabel.isHidden = true
            colorTextField.isHidden = true
            sizeLabel.isHidden = true
            sizeTextField.isHidden = true
        }
        else { // not
            tableView.isHidden = true
            addVariationButton.isHidden = true
            label3.isHidden = false
            usageStatusButton.isHidden = false
            quantityLabel.isHidden = false
            quantityTextField.isHidden = false
            colorLabel.isHidden = false
            colorTextField.isHidden = false
            sizeLabel.isHidden = false
            sizeTextField.isHidden = false
        }
    }
    
    public func addMorePhoto(_ pickedtype: PhotoPickerType){
        switch pickedtype {
        case .byCamera:
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            present(picker, animated: true)
        case .byLibrary:
            var config = PHPickerConfiguration(photoLibrary: .shared())
            config.selectionLimit = 10 - imageArr.count
            config.filter = .images
            let vc = PHPickerViewController(configuration: config)
            vc.delegate = self
            present(vc, animated: true)
        case .draft:
            return
        }
    }
    
    @objc func didTapClose() {
        dismiss(animated: true)
    }
    
    public func configure(with pickType: PhotoPickerType){
        self.pickedtype = pickType
    }

    private let photoLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos of product"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let addPhotoButon: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.contentHorizontalAlignment = .right
        return button
    }()

    
    private let photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
            let layouts = UICollectionViewCompositionalLayout.init { sectionIndex, environment in
                self.horizontalSection()
            }
            return layouts
    }
    private func horizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
                                              heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.orthogonalScrollingBehavior = .paging
            return section
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.text = "Detail product"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let label2: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let categoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("required", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 17)
        button.setImage(UIImage(systemName:"chevron.right"), for: .normal)
        let menu = UIMenu(title: "Categories", children: [
            UIMenu(title: "Fashion", children: [
                UIMenu(title: "Clothes", children: [
                    UIAction(title: "T-shirt", handler: { action in
                        button.setTitle("Fashion/Clothes/T-shirt", for: .normal)
                        button.setTitleColor(.black, for: .normal)
                    }),
                    UIAction(title: "Coat", handler: { action in
                        button.setTitle("Fashion/Clothes/Coat", for: .normal)
                        button.setTitleColor(.black, for: .normal)
                    }),
                    UIAction(title: "Pant", handler: { action in
                        button.setTitle("Fashion/Clothes/Pant", for: .normal)
                        button.setTitleColor(.black, for: .normal)
                    })
                ]),
                UIMenu(title: "Shoes", children: [
                    UIAction(title: "Sandal", handler: { action in
                        button.setTitle("Fashion/Shoes/Sandal", for: .normal)
                        button.setTitleColor(.black, for: .normal)
                    }),
                    UIAction(title: "Highheel", handler: { action in
                        button.setTitle("Fashion/Shoes/Highheel", for: .normal)
                        button.setTitleColor(.black, for: .normal)
                    }),
                    UIAction(title: "Sneaker", handler: { action in
                        button.setTitle("Fashion/Shoes/Sneaker", for: .normal)
                        button.setTitleColor(.black, for: .normal)
                    })
                ]),
                UIAction(title: "Jewelry", handler: { action in
                    button.setTitle("Fashion/Jewelry", for: .normal)
                    button.setTitleColor(.black, for: .normal)
                })
            ]),
            UIAction(title: "Books", handler: { action in
                button.setTitle("Books", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "PC/Laptop", handler: { action in
                button.setTitle("PC/Laptop", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "Toys", handler: { action in
                button.setTitle("Toys", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "Electronic Device", handler: { action in
                button.setTitle("Electronic Device", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "PC/Laptop", handler: { action in
                button.setTitle("PC/Laptop", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "Camera/Digital Camera", handler: { action in
                button.setTitle("Camera/Digital Camera", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "Home and Kitchen", handler: { action in
                button.setTitle("Home ad=nd Kitchen", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "Sports and Outdoor", handler: { action in
                button.setTitle("Sports and Outdoor", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
        ])
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    private let multiVariableChoiceLabel: UILabel = {
        let label = UILabel()
        label.text = "Multiple variation"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private let multiVariableChoiceButton: UISegmentedControl = {
        let control = UISegmentedControl(items: ["No","Yes"])
        control.selectedSegmentIndex = 0
        control.selectedSegmentTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        control.layer.borderWidth = 0.25
        control.layer.borderColor = UIColor.gray.cgColor
        return control
    }()
    
    private let addVariationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add varation", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.layer.borderWidth = 0.25
        button.layer.borderColor = UIColor.link.cgColor
        button.backgroundColor = .white
        button.contentMode = .center
        return button
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.text = "Brand"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let brandTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Brand name"
        field.textColor = .black
        field.textAlignment = .right
        return field
    }()
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Color"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let colorTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "White"
        field.textColor = .black
        field.textAlignment = .right
        return field
    }()
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Size"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let sizeTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "S/M/L"
        field.textColor = .black
        field.textAlignment = .right
        return field
    }()
    private let label3: UILabel = {
        let label = UILabel()
        label.text = "Usage status"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let usageStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("required", for: .normal)
        button.setImage(UIImage(systemName:"chevron.right"), for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 17)
        let menu = UIMenu(title: "Usage status", children: [
            UIAction(title: "New/Unused", handler: { action in
                button.setTitle("New/Unused", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "Almost unused", handler: { action in
                button.setTitle("Almost unused", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "There are no notice scratches or dirt", handler: { action in
                button.setTitle("No notice scratches or dirt", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "There are some scratches or dirt", handler: { action in
                button.setTitle("Some scratches or dirt", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "Scratches or dirt", handler: { action in
                button.setTitle("Scratches or dirt", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "Overall bad condition", handler: { action in
                button.setTitle("Overall bad condition", for: .normal)
                button.setTitleColor(.black, for: .normal)
            })
        ])
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "Quantity"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let quantityTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "1"
        field.textColor = .black
        field.textAlignment = .right
        return field
    }()
    
    private let label4: UILabel = {
        let label = UILabel()
        label.text = "Name and Description"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let label5: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let nameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Name product no more than 100 character"
        field.layer.masksToBounds = true
        field.layer.borderWidth = 0.25
        return field
    }()
    private let label6: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let descriptionTextField: UITextView = {
        let field = UITextView()
        field.font = UIFont.systemFont(ofSize: 17)
        field.isScrollEnabled = false
        field.backgroundColor = .secondarySystemBackground
        field.text = "Enter description about the product and no more than 1000 words ..."
        field.textColor = .lightGray
        return field
    }()
    
    private let label7: UILabel = {
        let label = UILabel()
        label.text = "Shipping method"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let label8: UILabel = {
        let label = UILabel()
        label.text = "Shipping fee"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let shippingFeeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName:"chevron.right"), for: .normal)
        button.setTitle("required", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 17)
        let menu = UIMenu(title: "Shipping fee pay by", children: [
            UIAction(title: "Seller", handler: { action in
                button.setTitle("Shipping fee pay by seller", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "Buyer", handler: { action in
                button.setTitle("Shipping fee pay by buyer", for: .normal)
                button.setTitleColor(.black, for: .normal)
            })
        ])
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    private let shippingMethodLabel: UILabel = {
        let label = UILabel()
        label.text = "Shipping method"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private let shippingMethodButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName:"chevron.right"), for: .normal)
        button.setTitle("required", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 17)
        let menu = UIMenu(title: "Shipping method", children: [
            UIAction(title: "Giaohangnhanh", handler: { action in
                button.setTitle("Giaohangnhanh", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "Giaohangtietkiem", handler: { action in
                button.setTitle("Giaihangtietkiem", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "VNPost EMS", handler: { action in
                button.setTitle("VNPost EMS", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "Self shipping", handler: { action in
                button.setTitle("Self shipping", for: .normal)
                button.setTitleColor(.black, for: .normal)
            })
        ])
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    private let shippingTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Days to ship"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private let shippingTimeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName:"chevron.right"), for: .normal)
        button.setTitle("required", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 17)
        let menu = UIMenu(title: "Product will be shipped in", children: [
            UIAction(title: "From 1 to 2 days", handler: { action in
                button.setTitle("From 1 to 2 days", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "From 3 to 4 days", handler: { action in
                button.setTitle("From 3 to 4 days", for: .normal)
                button.setTitleColor(.black, for: .normal)
            }),
            UIAction(title: "From 4 to 7 days", handler: { action in
                button.setTitle("From 4 to 7 days", for: .normal)
                button.setTitleColor(.black, for: .normal)
            })
        ])
        button.menu = menu
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    private let shippingStartRegionLabel: UILabel = {
        let label = UILabel()
        label.text = "Ship from"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private let shippingStartRegionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName:"chevron.right"), for: .normal)
        button.setTitle("Province", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.font = UIFont.italicSystemFont(ofSize: 17)
        return button
    }()
    
    private let priceSectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Selling price"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Sales price"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    private let priceTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "VND"
        field.layer.masksToBounds = true
        field.textAlignment = .right
        return field
    }()

    private let termAndPrivacyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = "Please be sure to check prohibited actions and products. Also, agree with privacy policy, then press Sell button."
        return label
    }()
    private let sellButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sell", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    private let saveDraftButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save draft", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 0.25
        return button
    }()
//    private let saveButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Save", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .red
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//        return button
//    }()
//    private let cancelButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Cancel", for: .normal)
//        button.setTitleColor(.red, for: .normal)
//        button.backgroundColor = .white
//        button.layer.borderColor = UIColor.red.cgColor
//        button.layer.borderWidth = 0.25
//        return button
//    }()
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        let scrollView = UIScrollView(frame: view.bounds)
        view.addSubview(scrollView)
        scrollView.contentSize = CGSize(width: view.width, height: view.height*1.8)
        
        scrollView.addSubview(photoLabel)
        scrollView.addSubview(addPhotoButon)
        scrollView.addSubview(photoCollectionView)
        scrollView.addSubview(label1)
        scrollView.addSubview(label2)
        scrollView.addSubview(categoryButton)
        scrollView.addSubview(multiVariableChoiceLabel)
        scrollView.addSubview(multiVariableChoiceButton)
        scrollView.addSubview(tableView)
        
        scrollView.addSubview(addVariationButton)
        scrollView.addSubview(label3)
        scrollView.addSubview(usageStatusButton)
        scrollView.addSubview(quantityLabel)
        scrollView.addSubview(quantityTextField)
        
        scrollView.addSubview(label4)
        scrollView.addSubview(label5)
        scrollView.addSubview(nameTextField)
        scrollView.addSubview(label6)
        scrollView.addSubview(descriptionTextField)
        
        scrollView.addSubview(label7)
        scrollView.addSubview(label8)
        scrollView.addSubview(shippingFeeButton)
        scrollView.addSubview(shippingMethodLabel)
        scrollView.addSubview(shippingMethodButton)
        scrollView.addSubview(shippingTimeLabel)
        scrollView.addSubview(shippingTimeButton)
        scrollView.addSubview(shippingStartRegionLabel)
        scrollView.addSubview(shippingStartRegionButton)
        
        scrollView.addSubview(priceSectionLabel)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(priceTextField)
        scrollView.addSubview(termAndPrivacyLabel)
        scrollView.addSubview(sellButton)
        scrollView.addSubview(saveDraftButton)

        scrollView.addSubview(brandLabel)
        scrollView.addSubview(brandTextField)
        scrollView.addSubview(colorLabel)
        scrollView.addSubview(colorTextField)
        scrollView.addSubview(sizeLabel)
        scrollView.addSubview(sizeTextField)
//
//        scrollView.addSubview(saveButton)
//        scrollView.addSubview(cancelButton)
//
        
        let size = view.width/5
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        photoCollectionView.collectionViewLayout = layout
        photoCollectionView.collectionViewLayout = createCompositionalLayout()
        photoCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        
        // choose shipping from
        var menuActions: [UIAction] = []
        for i in arrProvince {
            menuActions.append(UIAction(title: i.nameProvince, handler: {action in
                self.shippingStartRegionButton.setTitle(i.nameProvince, for: .normal)
                self.shippingStartRegionButton.setTitleColor(.black, for: .normal)
            }))
        }
        let menu = UIMenu(title: "Vietnam", children: menuActions)
        
        
        shippingStartRegionButton.menu = menu
        shippingStartRegionButton.showsMenuAsPrimaryAction = true
        addPhotoButon.addTarget(self, action: #selector(didTapAddMorePhoto), for: .touchUpInside)
        sellButton.addTarget(self, action: #selector(didTapSell), for: .touchUpInside)
        saveDraftButton.addTarget(self, action: #selector(didTapSaveDraft), for: .touchUpInside)
        multiVariableChoiceButton.addTarget(self, action: #selector(didTapChooseVariation(_ :)), for: .valueChanged)
        addVariationButton.addTarget(self, action: #selector(didTapAddVariation), for: .touchUpInside)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        

        photoLabel.frame = CGRect(x: 30, y: 0, width: view.width/2, height: 30)
        addPhotoButon.frame = CGRect(x: photoLabel.right, y: 0, width: view.width-view.width/2-60, height: 40)
        photoCollectionView.frame = CGRect(x: 30, y: photoLabel.bottom+5, width: view.width, height: size)
        //section 1
        
        label1.frame = CGRect(x: 30 , y: photoCollectionView.bottom + 15, width: view.width-60, height: 30)
        label2.frame = CGRect(x: 30, y: label1.bottom + 5, width: view.width/2, height: 30)
        categoryButton.frame = CGRect(x: label2.right + 10, y: label1.bottom+5, width: view.width-70-view.width/2, height: 30)
        brandLabel.frame = CGRect(x: 30, y: label2.bottom + 5, width: view.width/2, height: 30)
        brandTextField.frame = CGRect(x: brandLabel.right + 10, y: label2.bottom + 5, width:view.width-70-view.width/2, height: 30)
        multiVariableChoiceLabel.frame = CGRect(x: 30, y: brandLabel.bottom+5, width: view.width/2, height: 30)
        multiVariableChoiceButton.frame = CGRect(x: multiVariableChoiceLabel.right+10, y: brandLabel.bottom+5, width: view.width-view.width/2-70, height: 30)
        addVariationButton.frame = CGRect(x: 30, y: multiVariableChoiceLabel.bottom+5, width: view.width-60, height: 30)
        tableView.frame = CGRect(x: 30, y: addVariationButton.bottom+5, width: view.width-60, height: 100)
        colorLabel.frame = CGRect(x: 30, y: multiVariableChoiceLabel.bottom + 5, width: view.width/2, height: 30)
        colorTextField.frame = CGRect(x: colorLabel.right + 10, y: multiVariableChoiceLabel.bottom + 5, width:view.width-70-view.width/2, height: 30)
        sizeLabel.frame = CGRect(x: 30, y: colorLabel.bottom + 5, width: view.width/2, height: 30)
        sizeTextField.frame = CGRect(x: sizeLabel.right + 10, y: colorLabel.bottom + 5, width:view.width-70-view.width/2, height: 30)
        label3.frame = CGRect(x: 30, y: sizeLabel.bottom + 5, width: view.width/2, height: 30)
        usageStatusButton.frame = CGRect(x: label3.right + 10, y: sizeLabel.bottom+5, width: view.width-70-view.width/2, height: 30)
        quantityLabel.frame = CGRect(x: 30, y: label3.bottom + 5, width: view.width/2, height: 30)
        quantityTextField.frame = CGRect(x: quantityLabel.right + 10, y: label3.bottom + 5, width:view.width-70-view.width/2, height: 30)
        // section 2
        label4.frame = CGRect(x: 30, y: quantityLabel.bottom + 15, width: view.width-60, height: 30)
        label5.frame = CGRect(x: 30, y: label4.bottom + 5, width: view.width-60, height: 30)
        nameTextField.frame = CGRect(x: 30, y: label5.bottom + 3, width: view.width-60, height: 50)
        label6.frame = CGRect(x: 30, y: nameTextField.bottom + 5, width: view.width-60, height: 30)
        descriptionTextField.frame = CGRect(x: 30, y: label6.bottom + 3, width: view.width-60, height: 450)
        // section 3
        label7.frame = CGRect(x: 30, y: descriptionTextField.bottom+15, width: view.width-60, height: 30)
        label8.frame = CGRect(x: 30, y: label7.bottom+5, width: view.width/2, height: 30)
        shippingFeeButton.frame = CGRect(x: label8.right+10, y: label7.bottom+5, width: view.width-view.width/2-70, height: 30)
        shippingMethodLabel.frame = CGRect(x: 30, y: label8.bottom+5, width: view.width/2, height: 30)
        shippingMethodButton.frame = CGRect(x: shippingMethodLabel.right+10, y: label8.bottom+5, width: view.width-view.width/2-70, height: 30)
        shippingTimeLabel.frame = CGRect(x: 30, y: shippingMethodLabel.bottom+5, width: view.width/2, height: 30)
        shippingTimeButton.frame = CGRect(x: shippingTimeLabel.right+10, y: shippingMethodLabel.bottom+5, width: view.width-view.width/2-70, height: 30)
        shippingStartRegionLabel.frame = CGRect(x: 30, y: shippingTimeLabel.bottom+5, width: view.width/2, height: 30)
        shippingStartRegionButton.frame = CGRect(x: shippingStartRegionLabel.right + 10, y: shippingTimeLabel.bottom+5, width: view.width-view.width/2-70, height: 30)
        // section 4
        priceSectionLabel.frame = CGRect(x: 30, y: shippingStartRegionLabel.bottom+15, width: view.width-60, height: 30)
        priceLabel.frame = CGRect(x: 30, y: priceSectionLabel.bottom+5, width: view.width/2, height: 30)
        priceTextField.frame = CGRect(x: priceLabel.right + 10, y: priceSectionLabel.bottom+5, width: view.width-70-view.width/2, height: 30)
        // section 5
        termAndPrivacyLabel.frame = CGRect(x: 30, y: priceTextField.bottom+15, width: view.width-60, height: 80)
        sellButton.frame = CGRect(x: 30, y: termAndPrivacyLabel.bottom+10, width: view.width-60, height: 50)
        saveDraftButton.frame = CGRect(x: 30, y: sellButton.bottom+10, width: view.width-60, height: 30)
        
        // button for edit tap
//        saveButton.isHidden = true
//        cancelButton.isHidden = true
//        saveButton.frame = CGRect(x: 30, y: termAndPrivacyLabel.bottom+10, width: view.width-60, height: 50)
//        cancelButton.frame = CGRect(x: 30, y: sellButton.bottom+10, width: view.width-60, height: 30)
    }
    
    @objc private func didTapAddVariation() {
        print("Click button")
        let vc = AddVariationViewController()
        vc.delegate = self
//        vc.title = "Add new variation"
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    @objc private func didTapChooseVariation(_ sender: UISegmentedControl!) {
        if sender.selectedSegmentIndex == 0 {
            multipleVariation = false
            updateVariation()
        }
        else {
            multipleVariation = true
            updateVariation()
        }
    }
    @objc private func didTapAddMorePhoto(){
        let actionSheet = UIAlertController(title: "",
                                            message: "Add more product photos",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take by camera", style: .default, handler: { _ in
            self.addMorePhoto(.byCamera)
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose by library", style: .default, handler: { _ in
            self.addMorePhoto(.byLibrary)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionSheet, animated: true)
    }
    @objc private func didTapSell() {
        // gui data dang product upload
        productUpload = ProductUpload(title: nameTextField.text!, description: descriptionTextField.text, category: (categoryButton.titleLabel?.text)!, shippingFee: (shippingFeeButton.titleLabel?.text)!, brand: brandTextField.text, shippingMethod: (shippingMethodButton.titleLabel?.text)!, timeToShip: (shippingTimeButton.titleLabel?.text)!, departureRegion: (shippingStartRegionButton.titleLabel?.text)!, variation: listVariation, imageList: imageArr)
        
        DatabaseManager.shared.uploadProduct(productUpload!){ responseObject, error in
            if let error = error {
                print("Error: \(error)")
                // Handle the error
                
            } else if let responseObject = responseObject {
                print("Product: \(responseObject.title)")
                // Handle the response object
            }
        }
        var dialogMessage = UIAlertController(title: "Uploading", message: "Your product will be upload", preferredStyle: .alert)
        // Create OK button with action handler
        let ok = UIAlertAction(title: "See your post", style: .default, handler: { (action) -> Void in
            let pvc = self.presentingViewController
            self.dismiss(animated: true, completion: {
                let vc = MyProductViewController()
                vc.title = "Post"
                vc.configure(with: self.product!)
//                vc.modalPresentationStyle = .fullScreen
//                pvc?.navigationController?.pushViewController(vc, animated: true)
                pvc!.present(vc, animated: true, completion: nil)
            })
            
        })
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            self.dismiss(animated: true)
        }
        //Add OK and Cancel button to an Alert object
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        // Present alert message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    @objc private func didTapSaveDraft() {
        
    }

}

extension AddProductViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.lightGray {
                textView.text = ""
                textView.textColor = UIColor.black
            }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
    
            if textView.text == "" {
    
                textView.text = "Enter description about the product and no more than 1000 words ..."
                textView.textColor = UIColor.lightGray
            }
    }
//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        textView.resignFirstResponder()
//        return true
//    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if(quantityTextField.text == nil){
            quantityTextField.text = "1"
        }
        return true
    }
    
}

extension AddProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
//        print(image)
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self){ reading, error in
                if let image = reading as? UIImage, error == nil {
                    //                    print(image)
                    self.imageArr.append(image)
                    print(self.imageArr.count)
                }
                DispatchQueue.main.async {
                    self.photoCollectionView.reloadData()
                }
            }
        }
        
    }
}

extension AddProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if imageArr.count == 0 {
            return 4
        }
        if imageArr.count > 10{
            return 10
        }
        return imageArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        //        print("Dang hien thi cell \(indexPath.row)")
        //        print("day la so anh trong array \(imageArr.count)")
        //        let addButton = UIButton()
        //        addButton.setImage(UIImage(systemName: "camera"), for: .normal)
        //        cell.addSubview(addButton)
        //        addButton.frame = cell.bounds
        //        addButton.layer.borderWidth = 0.25
        let productPhoto1 = UIImageView()
        productPhoto1.layer.borderWidth = 1
        cell.addSubview(productPhoto1)
        productPhoto1.frame = cell.bounds
        
        if imageArr.count == 0 {
            productPhoto1.contentMode = .center
            productPhoto1.image = UIImage(systemName: "photo")
        } else {
            productPhoto1.contentMode = .scaleToFill
            productPhoto1.image = imageArr[indexPath.row]
        }
        
        if( imageArr.count == 10){
            self.addPhotoButon.isHidden = true
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)

        let dialogMessage = UIAlertController(title: "Delete this photo", message: "", preferredStyle: .alert)
        // Create OK button with action handler
        let ok = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            self.imageArr.remove(at: indexPath.row)
            self.addPhotoButon.isHidden = false
            collectionView.reloadData()
        })
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
//            self.dismiss(animated: true)
        }
        //Add OK and Cancel button to an Alert object
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        // Present alert message to user
        present(dialogMessage, animated: true, completion: nil)
        
    }
        
}
extension AddProductViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return variationArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = variationArr[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dialogMessage = UIAlertController(title: variationArr[indexPath.row], message: "", preferredStyle: .alert)
        // Create OK button with action handler
        let edit = UIAlertAction(title: "Edit", style: .default) { (action) -> Void in
            let vc = AddVariationViewController()
            vc.delegate = self
            vc.editVariation(with: self.listVariation[indexPath.row])
            self.present(UINavigationController(rootViewController: vc), animated: true)
        }
        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
            self.variationArr.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
//            self.dismiss(animated: true)
        }
        //Add OK and Cancel button to an Alert object
        dialogMessage.addAction(edit)
        dialogMessage.addAction(delete)
        dialogMessage.addAction(cancel)
        // Present alert message to user
        present(dialogMessage, animated: true, completion: nil)
    }
}
extension AddProductViewController: AddVariationViewControllerDelegate {
    func addVariationViewDidSubmitData(name: String, color: String, size: String, usageStatus: String, quantity: Int, price: Int) {
        var newVariation = "\(usageStatus) : \(quantity): \(price)VND"
        
        if !size.isEmpty {
            newVariation = "\(size), " + newVariation
        }
        if !name.isEmpty {
            newVariation = "\(name), " + newVariation
        }
        if !color.isEmpty {
            newVariation = "\(color), " + newVariation
        }
        
        let variation = Variations(name: name, color: color, size: size, usageStatus: usageStatus, quantity: quantity, price: price, isSold: false)
        listVariation.append(variation)
        // for display
        variationArr.append(newVariation)
        let indexPath = IndexPath(row: variationArr.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
//        print("\(name), \(usageStatus) : \(quantity)")
    }
}

