//
//  CameraViewController.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/02/07.
//

import UIKit
import AVFoundation
import MobileCoreServices

class CameraViewController: UIViewController {
        
        private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        
        override func viewDidLoad() {
            self.navigationItem.title = "Sell your items"
            collectionView.backgroundColor = .systemBackground
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            collectionView.frame = view.bounds
            collectionView.dataSource = self
            view.addSubview(collectionView)
            collectionView.collectionViewLayout = createCompositionalLayout()
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
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            
            return section
        }
        
        func createSecondSection()->NSCollectionLayoutSection {
            let inset = 2.5
            
            // item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            // group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.1))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            // section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            
            return section
        }
        
        func createThirdSection()->NSCollectionLayoutSection {
            let inset = 20.0
            
            // item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.25))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            // group
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
            
            // section
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            
            return section
        }

    }

    extension CameraViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 3
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return section == 2 ? 3 : 5
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            if(indexPath.section == 0){
                switch indexPath.row {
                case 0:
                    let imageView = UIImageView()
                    imageView.image = UIImage(named: "camera2")
                    imageView.contentMode = .scaleAspectFit
                    imageView.clipsToBounds = true
                    imageView.frame = cell.bounds
                    cell.addSubview(imageView)
                case 1:
                    let imageView = UIImageView()
                    imageView.image = UIImage(named: "camera4")
                    imageView.contentMode = .scaleAspectFit
                    imageView.clipsToBounds = true
                    imageView.frame = cell.bounds
                    cell.addSubview(imageView)
                default:
                    let imageView = UIImageView()
                    imageView.image = UIImage(named: "camera2")
                    imageView.contentMode = .scaleAspectFit
                    imageView.clipsToBounds = true
                    imageView.frame = cell.bounds
                    cell.addSubview(imageView)
                }
            }
            if(indexPath.section == 1) {
                cell.backgroundColor = .white
            }
            if(indexPath.section == 2) {
                switch indexPath.row {
                case 0:
                    let button = UIButton()
                    button.setImage(UIImage(systemName: "camera"), for: .normal)
                    button.tintColor = .label
                    button.clipsToBounds = true
                    button.frame = cell.bounds
                    button.layer.borderWidth = 1
                    button.contentMode = .center
                    cell.addSubview(button)
                    button.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
                case 1:
                    let button = UIButton()
                    button.setImage(UIImage(systemName: "photo.on.rectangle"), for: .normal)
                    button.tintColor = .label
                    button.clipsToBounds = true
                    button.frame = cell.bounds
                    button.layer.borderWidth = 1
                    button.contentMode = .center
                    cell.addSubview(button)
                    button.addTarget(self, action: #selector(didTapChoosePhoto), for: .touchUpInside)
                default:
                    let button = UIButton()
                    button.setImage(UIImage(systemName: "list.clipboard"), for: .normal)
                    button.tintColor = .label
                    button.clipsToBounds = true
                    button.frame = cell.bounds
                    button.layer.borderWidth = 1
                    button.contentMode = .center
                    cell.addSubview(button)
                    button.addTarget(self, action: #selector(didTapSeeDraft), for: .touchUpInside)
                }
            }
            return cell
        }
        @objc private func didTapTakePhoto() {
            let vc = AddProductViewController()
            vc.title = "Sell an item"
            present(UINavigationController(rootViewController: vc) , animated: true)
        }
        @objc private func didTapChoosePhoto() {
            let vc = AddProductViewController()
            vc.configure(with: .byLibrary)
            vc.title = "Sell an item"
            present(UINavigationController(rootViewController: vc) , animated: true)
            
        }
        @objc private func didTapSeeDraft() {
            let vc = AddProductViewController()
            vc.configure(with: .draft)
            vc.title = "Sell an item"
            present(UINavigationController(rootViewController: vc) , animated: true)
        }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                collectionView.deselectItem(at: indexPath, animated: true)
        }
    }

