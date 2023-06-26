//
//  UserGET.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/10.
//

import UIKit

struct UserMe: Codable {
    let email: String
    let isActive: Bool
    let isSuperuser: Bool
    let fullName: String?
    let username: String?
    let id: Int
}

func fetchData(withAccessToken accessToken: String, completion: @escaping (Result<UserMe, Error>) -> Void) {
    guard let url = URL(string: "http://127.0.0.1:8000/users/me") else {
        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.addValue("application/json", forHTTPHeaderField: "accept")
    request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
            return
        }
        
        do {
            //            print(String.init(from: data))
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let user = try decoder.decode(UserMe.self, from: data)
            completion(.success(user))
        } catch {
            completion(.failure(error))
        }
    }
    
    task.resume()
}

// Usage

//let accessToken = getAccessToken()
//fetchData(withAccessToken: accessToken!) { result in
//    switch result {
//    case .success(let user):
//        // Access the user object and its properties
//        print(user.username as Any)
//        print(user.email)
//    case .failure(let error):
//        // Handle the error
//        print("Error: \(error)")
//    }
//}

