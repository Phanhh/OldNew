//
//  TabBarController.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/23.
//

import UIKit

class TabBarController: UITabBarController {

    var userMe: Users?
    var favoritedId: [Int] = []
    var haveData = false
    override func viewDidLoad() {
        super.viewDidLoad()
//        if !haveData {
//            getMyInformation()
//        }
        // Do any additional setup after loading the view.
    }
//
//    func getMyInformation() {
//        DatabaseManager.shared.getMyInfor { (user, error) in
//            if let error = error {
//                print("Error retrieving user: \(error)")
//            } else if let user = user {
//                // Access the user object
//                self.userMe = user
//                print(user.id)
//                print(user.email)
//                // Access the user address associations
//                // Access the favorite associations
//                for favorite in user.favoriteAssociations {
//                    self.favoritedId.append(favorite.productId)
//                }
//
//                //                        print(favorite.userId)
//                //                        print(favorite.productId)
//                //                        print(favorite.isActive)
//                //                        print(favorite.id)
//            }
//        }
//        haveData = true
//    }

}
