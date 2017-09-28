//
//  CustomProgressIndicator.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/27/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit

class CustomProgressIndicator: NSObject {
    
    //Progress Indicator (Default)
    static let progressIndicator = UIActivityIndicatorView()
    
    //start progress view
    static func startProgressView (contentView : UIView?){
        if(contentView != nil){
            progressIndicator.frame = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: 50, height: 50))
            progressIndicator.center = (contentView?.center)!
            progressIndicator.startAnimating()
            progressIndicator.backgroundColor = UIColor.gray
            contentView?.addSubview(progressIndicator )
        }
    }
    
    //stop Progress view
    static func stopProgressView(contentView : UIView?){
        progressIndicator.stopAnimating()
        progressIndicator.removeFromSuperview()
    }
}
