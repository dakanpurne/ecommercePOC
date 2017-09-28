//
//  ProductItemCell.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/28/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit
protocol ProductItemCellDelegate: class {
    func didTapCell(index: IndexPath)
}
class ProductItemCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var vendorName: UILabel!
    @IBOutlet weak var vendorAddress: UILabel!
    
    var delegateCell:ProductItemCellDelegate?
    var indexPath:IndexPath?
    
    @IBAction func buttonCellClick(_ sender: Any) {
        delegateCell?.didTapCell(index: indexPath!)
    }
}
