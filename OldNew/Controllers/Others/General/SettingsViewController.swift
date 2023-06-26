//
//  SettingsViewController.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/02/07.
//

import UIKit
import SafariServices

struct SettingCellModel {
    let title: String
    let handle: (() -> Void)
}


// View Controller to show user setting
final class SettingsViewController: UIViewController {

    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels(){
    
        data.append([
            SettingCellModel(title: "Edit Profile") { [weak self] in
                self?.didTapEditProfile()
            },
            SettingCellModel(title: "Your Address") { [weak self] in
                self?.didTapSeeAddressList()
            },
            SettingCellModel(title: "Payment Method") { [weak self] in
                self?.didTapSeePaymentList()
            },
            SettingCellModel(title: "Purchased History") { [weak self] in
                self?.didTapPurchasedList()
            },
            SettingCellModel(title: "Reset password") { [weak self] in
                self?.didTapResetPassword()
            },
            SettingCellModel(title: "Invite Friends") { [weak self] in
                self?.didTapInviteFriends()
            }
        ])
        data.append([
            SettingCellModel(title: "Terms of Servise") { [weak self] in
                self?.openURL(type: .terms)
            },
            SettingCellModel(title: "Privacy Policy") { [weak self] in
                self?.openURL(type: .privacy)
            },
            SettingCellModel(title: "Help / Feedback") { [weak self] in
                self?.openURL(type: .help)
            }
        ])
        data.append([
            SettingCellModel(title: "Log out") { [weak self] in
                self?.didTapLogOut()
            }
        ])
            
    }
    
    public enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType){
        let urlString: String
        switch type {
        case .terms:
            urlString = "https://help.instagram.com/581066165581870"
        case .privacy:
            urlString = "https://privacycenter.instagram.com/policy"
        case .help:
            urlString = "https://help.instagram.com/"
        }
        guard let url = URL(string: urlString) else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func didTapSeeAddressList(){
        let vc = MyAddressViewController()
        vc.title = "My Addresses"
        navigationController?.pushViewController(vc, animated: true)
    }
    private func didTapSeePaymentList(){
        
    }
    private func didTapResetPassword(){
        
    }
    
    private func didTapPurchasedList(){
        
    }
    
    private func didTapInviteFriends(){
        // show share sheet to invite friends
    }
    
    private func didTapEditProfile(){
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func didTapLogOut(){
        
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            removeAccessToken()
            NotificationCenter.default.post(name: NSNotification.Name("ResetMyInforNotification"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("ResetMyProductsNotification"), object: nil)
            if let savedToken = getAccessToken() {
                fatalError("Could not log out user")
            } else {
                DispatchQueue.main.async {
                        //present log in
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true) {
                        self.navigationController?.popToRootViewController(animated: false)
                        self.tabBarController?.selectedIndex = 0
                    }
                    }
                    
                }
            }
        ))
        
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(actionSheet, animated: true)
    }

}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // handle cell selected
        data[indexPath.section][indexPath.row].handle()
    }
}
