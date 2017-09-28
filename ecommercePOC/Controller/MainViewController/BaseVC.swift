//
//  ViewController.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/27/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeCall(phoneNumber: String) {
        let formattedNumber = phoneNumber.components(separatedBy:
            NSCharacterSet.decimalDigits.inverted).joined(separator: "")
        
        let phoneUrl = "tel://\(formattedNumber)"
        let url:NSURL = NSURL(string: phoneUrl)!
        
        if #available(iOS 10, *) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler:
                nil)
        } else {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
}

