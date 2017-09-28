//
//  ProductListService.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/28/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit
import Alamofire

class ProductListService: BaseService {
    
    static let sharedInstance = ProductListService()
    private override init() {}
    
    //get product list service call
    internal func getProductListService(completionHandler: @escaping (_ response: KServerResponseModel?) -> ()) {
        
        let getproductListURLPath = http_baseURL + http_get_productlistURL
        
        Alamofire.request(getproductListURLPath, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseString{ [weak self](response) in
            debugPrint(response)
            
            switch response.result {
            case .success(let value):
                let itemListResponseMode = ProductResponseModel.init(JSONString: value)
                self?.ktServiceResponseModel.responseData = itemListResponseMode as AnyObject
                completionHandler(self?.ktServiceResponseModel)
                break
            case .failure(let errors):
                self?.ktServiceResponseModel.error = errors
                completionHandler(self?.ktServiceResponseModel)
                break
            }
            
        }
    }
}

