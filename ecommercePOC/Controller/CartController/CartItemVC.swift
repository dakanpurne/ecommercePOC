//
//  SecondViewController.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/27/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit
import CoreData

class CartItemVC: BaseVC,UITableViewDelegate,UITableViewDataSource,CartItemCellDelegate {
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    lazy var objArray = [EntityProductList]()
    var obj = EntityProductList()
    let reuseIdentifier = "cartItemCell"
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProductItemListFromDB()
        tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get a reference to our storyboard cell
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CartItemCell
        
        obj = objArray[indexPath.row]

        cell.delegateCartItemCell = self
        cell.indexPath = indexPath
        
        cell.productName.text = obj.productname
        if obj.productImg != nil{
            ImageDownloadUtil.downloadImageFromURL(imageURL: obj.productImg, completionClosure: { (response) in
                cell.productImage.image = response
            })
        }
        
        cell.priceValue.text = NSString(format: "%.2f", obj.price) as String
        cell.vendorName.text = obj.vendorname
        cell.vendorAddress.text = obj.vendoraddress
        
        return cell
    }

    func didTapRemoveItemButton(index: IndexPath) {
        obj = objArray[index.row]
        deleteCartItemFromDB(obj: obj)
    }
    
    func didTapCallNumber(index: IndexPath) {
        obj = objArray[index.row]
        makeCall(phoneNumber: obj.phoneNumber!)
    }
    
    func getProductItemListFromDB(){
        let responseObj: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: kProductList)
        do {
            if let results = try self.appDelegate.coreDataStack.managedObjectContext.fetch(responseObj) as? [NSManagedObject] {
                
                let myFavArray: [EntityProductList]? = results as? [EntityProductList]
                
                if myFavArray != nil {
                    self.objArray = myFavArray!
                    totalPrice.text = kTotalPrice + calculateFinalPrice(obj: self.objArray)
                }
            }
        }
        catch {
            fatalError("There was an error fetching the items")
        }
    }
    
    func calculateFinalPrice(obj:[EntityProductList]) -> String {
        var tot: Float = 0.00
        for index in obj {
            tot = tot+index.price
        }
        
        return NSString(format: "%.2f", tot) as String
    }
    
    //method to delete favourite item from db
    func deleteCartItemFromDB(obj:EntityProductList)  {
        self.appDelegate.coreDataStack.managedObjectContext.delete(obj)
        self.appDelegate.coreDataStack.saveContext()
        
        getProductItemListFromDB()
        tableView.reloadData()
    }
}

