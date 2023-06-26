//
//  VariationModel.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/22.
//

import Foundation

struct Variations: Codable {
    let name: String?
    let color: String?
    let size: String?
    let usageStatus: String
    let quantity: Int
    let price: Int
    let isSold: Bool
    
//    enum CodingKeys: String, CodingKey {
//        case name, quantity, color, size, price
//        case usageStatus = "usage_status"
//        case isSold = "is_sold"
//    }
}
