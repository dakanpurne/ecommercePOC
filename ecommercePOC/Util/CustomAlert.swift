//
//  CustomAlert.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/28/17.
//  Copyright © 2017 sample. All rights reserved.
//
import UIKit

class CustomAlert: NSObject {
    
    static internal  func showAlertWithMessage(message:String? ,viewObj:UIViewController?) {
        let okTitle = NSLocalizedString(kAlertOKBtnTitle, comment: kAlertOKBtnTitle)
        _ = NSLocalizedString(kAlert, comment: kAlert)
        
        let alert = UIAlertController(title: kAlert, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: okTitle, style: UIAlertActionStyle.default, handler: nil))
        viewObj?.present(alert, animated: true, completion: nil)
        
    }
    
    static internal  func showAlertWithMessageAndOkHandler(message:String? ,viewObj:UIViewController?, okTitle : String ,okHandler: @escaping () -> Void) {
        _ = NSLocalizedString(kAlert, comment: kAlert)
        let alert = UIAlertController(title: kAlert, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: okTitle, style: UIAlertActionStyle.default, handler: { (alertAction) in
            okHandler()
        }))
        viewObj?.present(alert, animated: true, completion: nil)
    }
    
    static internal  func showAlertWithCancelAndOkHandler(message:String? ,viewObj:UIViewController? ,okTitle : String ,cancelTitle : String ,okHandler: @escaping () -> Void) {
        _ = NSLocalizedString(kAlert, comment: kAlert)
        
        let alert = UIAlertController(title: kAlert, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: cancelTitle, style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: okTitle, style: UIAlertActionStyle.default, handler: { (alertAction) in
            okHandler()
        }))
        viewObj?.present(alert, animated: true, completion: nil)
    }
    

}
