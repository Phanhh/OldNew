//
//  AuthManager.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/02/10.
//

import UIKit

public class AuthManager {

    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(password: String,email: String, full_name: String,  completion: @escaping (Error?) -> Void) {
        let parameters = [
            "password": password,
            "email": email,
            "full_name": full_name
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            let url = URL(string: "http://127.0.0.1:8000/users/open")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "accept")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(error)
                    return
                }
                
                // Process the response as needed
                
                completion(nil)
            }
            
            task.resume()
        } catch {
            completion(error)
        }
        /*
         - check username is available
         - Check email is available
         - Create Account
         - Insert to DB
         */
    }

    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "http://127.0.0.1:8000/login/access-token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let formData = "username=\(username)&password=\(password)"
        let formDataEncoded = formData.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let requestBodyData = formDataEncoded.data(using: .utf8)
        
        request.httpBody = requestBodyData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                return
            }
            
            guard response.statusCode == 200 else {
                completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: nil)))
                return
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let accessToken = json?["access_token"] as? String {
                        completion(.success(accessToken))
                    } else {
                        completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                    }
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            }
        }
        
        task.resume()
    }

    
//    public func logOut(completion: (Bool) -> Void) {
//        do {
//            removeAccessToken()
//            completion(true)
//        }
//        catch {
//            completion(false)
//            print(error)
//            return
//        }
//    }
}
