//
//  StorageManager.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/02/10.
//

import FirebaseStorage
import Foundation

public class StorageManager{
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum StorageManegerError: Error {
        case failedToDownload
    }
    
    // MARK: - Public
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL,StorageManegerError>) -> Void ) {
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let  url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            
            completion(.success(url))
        })
    }
    
    
}

