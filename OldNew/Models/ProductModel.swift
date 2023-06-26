//
//  ProductModel.swift
//  CompositionalLayout
//
//  Created by Phuong Anh Bui on 2023/06/09.
//

import Foundation
import UIKit

enum ShippingBy {
    case bySeller, byBuyer
}
enum TimeToShip {
    case oneToTwo, threeToFour, fourToSeven
}
enum useStatus {
    case newUnused, likeNew, noStraint, someStraint, old, veryOld
}
struct UsageStatus{
    let id: Int
    let type: useStatus
}

struct Products {
    let title: String
    let description: String
    let category: String
    let shippingFee: String
    let brand: String?
    let shippingMethod: String
    let timeToShip: String
    let departureRegion: String
    let variation: [VariationReceive]
    let imageList: [UIImage]
}

struct ProductUpload {
    let title: String
    let description: String
    let category: String
    let shippingFee: String
    let brand: String?
    let shippingMethod: String
    let timeToShip: String
    let departureRegion: String
    let variation: [Variations]
    let imageList: [UIImage]
}

struct ProductRequest: Codable {
    let title: String
    let description: String
    let category: String
    let shippingFee: String
    let brand: String?
    let shippingMethod: String
    let timeToShip: String
    let departureRegion: String

//    enum CodingKeys: String, CodingKey {
//        case title, description, category, brand
//        case shippingFee = "shipping_fee"
//        case shippingMethod = "shipping_method"
//        case timeToShip = "time_to_ship"
//        case departureRegion = "departure_region"
//    }
}




//extension Product {
//    static func all() -> [Product] {
//        return [
//            Product(productID: 1, imageList: [UIImage(named: "productPhoto1")], name: "Fujifilm Instax mini 8", description: "", categoryID: 6, usageStatus: .newUnused , quantity: 1, shippingFee: .bySeller, shippingMethod: 1, timeToShip: .oneToTwo, departureRegion: "Hanoi", price: "1.000.000", sellerID: 1)
//        ]
//    }
//}
