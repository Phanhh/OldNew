//
//  Variation+CoreDataProperties.swift
//  OldNew
//
//  Created by Phuong Anh Bui on 2023/06/23.
//
//

import Foundation
import CoreData


extension Variation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Variation> {
        return NSFetchRequest<Variation>(entityName: "Variation")
    }

    @NSManaged public var id: Int32
    @NSManaged public var quantity: Int32
    @NSManaged public var size: String?
    @NSManaged public var isSold: Bool
    @NSManaged public var usageStatus: String?
    @NSManaged public var name: String?
    @NSManaged public var color: String?
    @NSManaged public var price: Int32
    @NSManaged public var productId: Int32
    @NSManaged public var product: Product?

}

extension Variation : Identifiable {

}
