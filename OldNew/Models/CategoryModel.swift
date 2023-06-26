//
//  CategoryModel.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/13.
//

import Foundation

public struct Category {
    let id: Int
    let name: String
    let imagePhoto: String
}

extension Category {
    static func all() -> [Category] {
        return [
            Category(id: 1, name: "Clother", imagePhoto: "Image1"),
            Category(id: 2, name: "Book", imagePhoto: "Image2"),
            Category(id: 3, name: "Toy", imagePhoto: "Image1"),
            Category(id: 4, name: "Electronic Device", imagePhoto: "Image2"),
            Category(id: 5, name: "PC/Laptop", imagePhoto: "Image1"),
            Category(id: 6, name: "Camera/Digital Camera", imagePhoto: "Image2")
        ]
    }
}


