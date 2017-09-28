//
//  ProductResponseModel.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/28/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit
import ObjectMapper

class ProductResponseModel: Mappable {
    var products: [ProductItemResponseModel]?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        products <- map["products"]
    }
}
