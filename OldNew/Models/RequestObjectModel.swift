//
//  RequestObjectModel.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/22.
//

import Foundation

struct ProductReceive: Codable {
    let title: String
    let description: String
    let category: String
    let shippingFee: String
    let brand: String
    let shippingMethod: String
    let timeToShip: String
    let departureRegion: String
    let id: Int
    let ownerId: Int
    let imageList: [String]
    let variations: [VariationReceive]
}

struct VariationReceive: Codable {
    let id: Int
    let quantity: Int
    let size: String
    let isSold: Bool
    let usageStatus: String
    let name: String
    let color: String
    let price: Int
    let productId: Int
}

struct Users: Codable {
    let email: String
    let isActive: Bool
    let isSuperuser: Bool
    let fullName: String?
    let id: Int
    let userAddressAssociations: [UserAddressAssociation]
    let favoriteAssociations: [FavoriteAssociation]
}


struct UserAddressAssociation: Codable {
    let address: Address
}

struct Address: Codable {
    let city: String
    let ward: String
    let district: String
    let street: String
    let id: Int
}

struct FavoriteAssociation: Codable {
    let userId: Int
    let productId: Int
    let isActive: Bool
    let id: Int
}
