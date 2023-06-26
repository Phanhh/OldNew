//
//  DatabaseManager.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/02/10.
//

import Alamofire
import Foundation
import UIKit



public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    func uploadProduct(_ data: ProductUpload, completion: @escaping (ProductReceive?, Error?) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:8000/product/") else {
            print("Invalid URL")
            return
        }
        let accessToken = getAccessToken()
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        let product = ProductRequest(
            title: data.title,
            description: data.description,
            category: data.category,
            shippingFee: data.shippingFee,
            brand: data.brand,
            shippingMethod: data.shippingMethod,
            timeToShip: data.timeToShip,
            departureRegion: data.departureRegion
        )
        let variation = data.variation
        let images = data.imageList
        
        AF.upload(multipartFormData: { multipartFormData in
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            if let productData = try? encoder.encode(product) {
                multipartFormData.append(productData, withName: "product")
            }
            
            if let variationData = try? encoder.encode(variation) {
                multipartFormData.append(variationData, withName: "variations_list")
            }
            
            for (index, images) in images.enumerated() {
                if let imageData = images.jpegData(compressionQuality: 0.8) {
                    multipartFormData.append(imageData, withName: "files", fileName: "image\(index + 1).jpg", mimeType: "image/jpeg")
                }
            }
        }, to: url, method: .post, headers: headers)
        .responseDecodable(of: ProductReceive.self) { response in
            switch response.result {
            case .success(let responseObject):
                completion(responseObject, nil)
                print("Message: \(responseObject.title)")
                print("Product: \(responseObject.brand)")
                // Handle the response object
                
            case .failure(let error):
                print("Error: \(error)")
                completion(nil, error)
                // Handle the error
            }
        }
    }
    
    // usage
//    uploadProduct(product) { responseObject, error in
//        if let error = error {
//            print("Error: \(error)")
//            // Handle the error
//
//        } else if let responseObject = responseObject {
//            print("Message: \(responseObject.message)")
//            print("Product: \(responseObject.data)")
//            // Handle the response object
//        }
//    }
    
    // doc san pham bang id
    
    func getProductInfor(id: Int, completion: @escaping (Result<ProductReceive, Error>) -> Void) {
        
        guard let url = URL(string: "http://127.0.0.1:8000/product/" + String(id)) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer " + getAccessToken()!, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                    print("Error: \(error)")
                    return
                }

            if let httpResponse = response as? HTTPURLResponse {
                if !(200...299).contains(httpResponse.statusCode) {
                    print("HTTP Error: \(httpResponse.statusCode)")
                    return
                }
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let product = try decoder.decode(ProductReceive.self, from: data)
                        completion(.success(product))
                    } catch {
                        completion(.failure(error))
                    }
        }
        
        task.resume()
    }
    
    // Usage
//    getProductInfor(id: 3) { result in
//        switch result {
//        case .success(let product):
//            // Handle successful response
//            print("Product title: \(product.title)")
//            print("Product image: \(product.imageList[0])")
//            let image = UIImage(data: Data(base64Encoded: product.imageList[0])!)
//
//        case .failure(let error):
//            // Handle error
//            print("Error retrieving product information: \(error)")
//        }
//    }

    // readAll = true : Read all product
    // readAll = false: Read my product
    func getProducts(withAccessToken accessToken: String, readAll: Bool, completion: @escaping (Result<[ProductReceive], Error>) -> Void) {
        
        guard let url = URL(string: "http://127.0.0.1:8000/product/?skip=0&limit=100&read_all=\(readAll)") else {
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
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let parentObjects = try decoder.decode([ProductReceive].self, from: data)

                completion(.success(parentObjects))
                // list of ProductReceive -> Truyen vao List product
                
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }

    // Usage
//    getProducts(withAccessToken: accessToken!, readAll: false) { result in
//        switch result {
//            case .success(let parentObjects):
//                // Access the array of User objects
//            for parent in parentObjects {
//                print(parent.id)
//                print(parent.imageList[0])
//
//                for child in parent.variations {
//                    print(child.id)
//                    print(child.name)
//                }
//
//                print("---")
//            }
//            case .failure(let error):
//                // Handle the error
//                print("Error: \(error)")
//            }
//    }
    
    func getMyInfor(withAccessToken accessToken: String, completion: @escaping (Users?, Error?) -> Void) {
        let urlString = "http://127.0.0.1:8000/users/me"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer \(accessToken)))", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(Users.self, from: data)
                completion(user, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
    // Usage
    
//    getMyInfor { (user, error) in
//        if let error = error {
//            print("Error retrieving user: \(error)")
//        } else if let user = user {
//            // Access the user object
//            print(user.email)
//            print(user.isActive)
//            print(user.fullName)
//            print(user.id)
//
//            // Access the user address associations
//            for addressAssociation in user.userAddressAssociations {
//                let address = addressAssociation.address
//                print(address.city)
//                print(address.ward)
//                print(address.district)
//                print(address.street)
//                print(address.id)
//            }
//
//            // Access the favorite associations
//            for favorite in user.favoriteAssociations {
//                print(favorite.userId)
//                print(favorite.productId)
//                print(favorite.isActive)
//                print(favorite.id)
//            }
//        }
//    }

}

