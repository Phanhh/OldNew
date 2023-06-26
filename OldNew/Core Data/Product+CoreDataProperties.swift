//
//  Product+CoreDataProperties.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/23.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var title: String?
    @NSManaged public var category: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var shippingFee: String?
    @NSManaged public var brand: String?
    @NSManaged public var shippingMethod: String?
    @NSManaged public var timeToShip: String?
    @NSManaged public var departureRegion: String?
    @NSManaged public var imageList: Data?
    @NSManaged public var id: Int32
    @NSManaged public var ownerId: Int32
    @NSManaged public var variations: NSSet?

}

// MARK: Generated accessors for variations
extension Product {

    @objc(addVariationsObject:)
    @NSManaged public func addToVariations(_ value: Variation)

    @objc(removeVariationsObject:)
    @NSManaged public func removeFromVariations(_ value: Variation)

    @objc(addVariations:)
    @NSManaged public func addToVariations(_ values: NSSet)

    @objc(removeVariations:)
    @NSManaged public func removeFromVariations(_ values: NSSet)

}

extension Product : Identifiable {

}
