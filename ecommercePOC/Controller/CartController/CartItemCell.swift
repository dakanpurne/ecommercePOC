//
//  CartItemCell.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/28/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit

protocol CartItemCellDelegate: class {
    func didTapRemoveItemButton(index: IndexPath)
    func didTapCallNumber(index:IndexPath)
}

class CartItemCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var vendorAddress: UILabel!
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var priceValue: UILabel!
    
    @IBAction func callVendorAction(_ sender: Any) {
        delegateCartItemCell?.didTapCallNumber(index: indexPath!)
    }
    
    @IBAction func removeFromCartAction(_ sender: Any) {
        delegateCartItemCell?.didTapRemoveItemButton(index: indexPath!)
    }
    
    var delegateCartItemCell:CartItemCellDelegate?
    var indexPath:IndexPath?
}
