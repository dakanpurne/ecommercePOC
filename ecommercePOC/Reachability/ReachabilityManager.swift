//
//  ReachabilityManager.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/27/17.
//  Copyright © 2017 sample. All rights reserved.
//
import UIKit
import Foundation

class ReachabilityManager: NSObject {
    
    static internal func isReachable() -> Bool {
        
        return Reachability .forInternetConnection().currentReachabilityStatus() != NotReachable
    }
 
}
