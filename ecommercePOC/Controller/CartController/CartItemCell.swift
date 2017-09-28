//
//  CartItemCell.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/28/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit
class CartItemCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var vendorAddress: UILabel!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var priceValue: UILabel!
    
    @IBAction func callVendorAction(_ sender: Any) {
    }
    
    @IBAction func removeFromCartAction(_ sender: Any) {
    }
}
