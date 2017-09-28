//
//  FirstViewController.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/27/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit
import CoreData


class ProductListVC: BaseVC, UICollectionViewDelegate,UICollectionViewDataSource,ProductItemCellDelegate {
    
    lazy var productList = [ProductItemResponseModel]()
    @IBOutlet weak var collectionView: UICollectionView!
    var obj = ProductItemResponseModel()
    let dbmanagerObj = DBOperationManager()
    let reuseIdentifier = "productItemCell" 
    var myProductObj : EntityProductList?
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.delegateCell = self
        cell.indexPath = indexPath
        
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
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func didTapCell(index: IndexPath) {
        print("collection cell button click index >> \(index.row)")
        let dbObj: NSEntityDescription? = NSEntityDescription.entity(forEntityName: kProductList, in: self.appDelegate.coreDataStack.managedObjectContext)
        if dbObj != nil {
            self.myProductObj = EntityProductList(entity: dbObj!, insertInto: self.appDelegate.coreDataStack.managedObjectContext)
            obj = productList[index.row]
            
            self.myProductObj?.productname = obj.productname
            self.myProductObj?.productImg = obj.productImg
            self.myProductObj?.price = NumberFormatter().number(from: obj.price!)!.floatValue
            self.myProductObj?.phoneNumber = obj.phoneNumber
            self.myProductObj?.vendorname = obj.vendorname
            self.myProductObj?.vendoraddress = obj.vendoraddress
            self.appDelegate.coreDataStack.saveContext()
        }
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


