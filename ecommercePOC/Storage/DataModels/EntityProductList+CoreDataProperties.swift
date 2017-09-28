//
//  EntityProductList+CoreDataProperties.swift
//  
//
//  Created by Dnyaneshwar Kanpurne on 9/28/17.
//
//

import Foundation
import CoreData


extension EntityProductList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntityProductList> {
        return NSFetchRequest<EntityProductList>(entityName: "EntityProductList")
    }

    @NSManaged public var phoneNumber: String?
    @NSManaged public var productname: String?
    @NSManaged public var price: Float
    @NSManaged public var vendorname: String?
    @NSManaged public var vendoraddress: String?
    @NSManaged public var productImg: String?

}
