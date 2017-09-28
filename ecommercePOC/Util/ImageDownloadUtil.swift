//
//  ImageDownloadUtil.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/28/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ImageDownloadUtil : NSObject{
    
    //download an image from url using Almofire and AlmofireImage
    static internal func downloadImageFromURL(imageURL:String?,completionClosure: @escaping (_ response: UIImage?)-> ()) {
        let escaptedURL = imageURL?.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)
        if escaptedURL != nil{
            Alamofire.request(escaptedURL!).responseImage { response in
                debugPrint(response)
                debugPrint(response.result)
                
                if let image = response.result.value {
                    completionClosure(image)
                }
            }
            
        }
    }
}
