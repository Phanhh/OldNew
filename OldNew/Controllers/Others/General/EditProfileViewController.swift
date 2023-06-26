//
//  EditProfileViewController.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/02/07.
//

import UIKit
import PhotosUI

protocol EditProfileViewControllerDelegate: AnyObject {
    func didTapSaveChangeProfie(_ sender: Users)
}


struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}

class EditProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: EditProfileViewControllerDelegate?
    
    private var user: Users?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()

    private var  models = [[EditProfileFormModel]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        tableView.tableHeaderView = createTableHeaderView()
        tableView.dataSource = self
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done, target: self,
                                                            action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain, target: self,
                                                            action: #selector(didTapCancel))
    }
    
    private func configureModels() {
        // name, username, bio
        let sectionLabels = ["Name", "Username", "Bio"]
        var section1 = [EditProfileFormModel]()
        for label in sectionLabels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label):", value: nil)
            section1.append(model)
        }
        models.append(section1)
        let sectionLabels2 = ["Email", "Phonenumber", "Gender"]
        var section2 = [EditProfileFormModel]()
        for label in sectionLabels2 {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label):", value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Tableview
    
    private let profilePhotoButton: UIButton = {
        let profilePhotoButton = UIButton()
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.tintColor = .label
        profilePhotoButton.setBackgroundImage(UIImage(named: "avatar2"),
                                              for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        return profilePhotoButton
    }()
    
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        let size = header.height/1.5
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.frame = CGRect(x: (view.width-size)/2,
                                        y: (view.height/4-size)/2,
                                        width: size,
                                        height: size)
        profilePhotoButton.addTarget(self,
                                     action: #selector(didTapProfilePhotoButton),
                                     for: .touchUpInside)
        return header
    }
    
    @objc private func didTapProfilePhotoButton() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        return "Private Information"
        
    }
    
    // MARK: - Action
    @objc private func didTapSave() {
        //save to database
//        user = Users(imagePhoto: profilePhotoButton.currentBackgroundImage!, name: "Phuong Anh Bui", username: "phuonganh", bio: "Life always offers you a second chance. It’s called tomorrow.", email: "phanh@oldnew.com", phonenumber: "012345678", gender: .female, counts: UserCount(posts: 3), joinDate: Date())
        
        delegate?.didTapSaveChangeProfie(user!)
        dismiss(animated: true, completion: nil)
        
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "Change profile picture",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        present(actionSheet, animated: true)
    }
}

extension EditProfileViewController: FormTableViewCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel?) {
        // Update to model 
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        profilePhotoButton.setBackgroundImage(image, for: .normal)
    }

}

