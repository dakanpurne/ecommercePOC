//
//  FirstViewController.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/27/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit

class ProductListVC: UIViewController {
    lazy var productList = [ProductResponseModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        callProductListService()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func callProductListService(){
        CustomProgressIndicator.startProgressView(contentView: self.view)
        if ReachabilityManager.isReachable() {
            var kServerResponseObj = KServerResponseModel()
            ProductListService.sharedInstance.getProductListService( completionHandler: { [weak self](response) in
                kServerResponseObj = response!
                if kServerResponseObj.error == nil {
                    
                    if let productListResponseModel = kServerResponseObj.responseData as? ProductResponseModel {
                        
                        self?.productList = [productListResponseModel]
                        CustomProgressIndicator.stopProgressView(contentView: self?.view)
                    }
                }else{
                    CustomAlert.showAlertWithMessage(message: kServerError, viewObj:self)
                    CustomProgressIndicator.stopProgressView(contentView: self?.view)
                }
            })
        }
        else{
            CustomAlert.showAlertWithMessage(message: kErrorNetworkUnavailable, viewObj:self)
            CustomProgressIndicator.stopProgressView(contentView: self.view)
        }
    }
    
}

