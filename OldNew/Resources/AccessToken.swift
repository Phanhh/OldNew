//
//  AccessToken.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/15.
//

import Foundation

// Save access token
func saveAccessToken(_ accessToken: String) {
    UserDefaults.standard.set(accessToken, forKey: "AccessToken")
}

// Retrieve access token
func getAccessToken() -> String? {
    return UserDefaults.standard.string(forKey: "AccessToken")
}

// Remove access token
func removeAccessToken() {
    UserDefaults.standard.removeObject(forKey: "AccessToken")
}

func validateAccessToken(completion: @escaping (Bool) -> Void) {
    guard let accessToken = getAccessToken() else {
        // Access token not found, handle the error or redirect to login
        completion(false)
        return
    }
    print(accessToken)
    let url = URL(string: "http://127.0.0.1:8000/login/test-token")!
    var request = URLRequest(url: url)
    request.addValue("application/json", forHTTPHeaderField: "accept")
    request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
            // Error occurred, handle the error or redirect to login
            print("Error: \(error)")
            completion(false)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            // Invalid response, handle the error or redirect to login
            completion(false)
            return
        }
        
        if httpResponse.statusCode == 200 {
            // Access token is valid, user is logged in
//            print("Success")
            completion(true)
        } else {
            // Access token is invalid, handle the error or redirect to login
            completion(false)
        }
    }
    
    task.resume()
}
