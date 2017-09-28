//
//  FirstViewController.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/27/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit

class ProductListVC: BaseVC, UICollectionViewDelegate,UICollectionViewDataSource {
    
    lazy var productList = [ProductItemResponseModel]()
    @IBOutlet weak var collectionView: UICollectionView!
    var obj = ProductItemResponseModel()
    
    let reuseIdentifier = "productItemCell" // also enter this string as the cell identifier in the storyboard
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        callProductListService()
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productList.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ProductItemCell
        
        obj = productList[indexPath.row]
        cell.productName.text = obj.productname
        if obj.productImg != nil{
            ImageDownloadUtil.downloadImageFromURL(imageURL: obj.productImg, completionClosure: { (response) in
                cell.productImage.image = response
            })
        }
        cell.productPrice.text = kPriceLabel + obj.price!
        cell.vendorName.text = obj.vendorname
        cell.vendorAddress.text = obj.vendoraddress

        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
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
                        
                        self?.productList = productListResponseModel.products!
                        CustomProgressIndicator.stopProgressView(contentView: self?.view)
                        self?.collectionView.reloadData()
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


