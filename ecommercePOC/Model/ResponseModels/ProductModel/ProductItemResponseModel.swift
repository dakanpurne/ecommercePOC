//
//  ProductItemResponseModel.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/28/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit
import ObjectMapper

class ProductItemResponseModel: Mappable {
    
    var productname: String?
    var price: String?
    var vendorname: String?
    var vendoraddress: String?
    var productImg: String?
    var phoneNumber: String?
    
    //var productGallery: []?
    
    init() {
    }
    
    required init?(map: Map){
    }
    
    // Mappable
    func mapping(map: Map) {
        self.productname <- map["productname"]
        self.price <- map["price"]
        self.vendorname <- map["vendorname"]
        self.vendoraddress <- map["vendoraddress"]
        self.productImg <- map["productImg"]
        self.phoneNumber <- map["phoneNumber"]
        
    }
}


