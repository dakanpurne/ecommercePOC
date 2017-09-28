//
//  SecondViewController.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/27/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit
import CoreData

class CartItemVC: BaseVC,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var objArray = [EntityProductList]()
    var obj = EntityProductList()
    let reuseIdentifier = "cartItemCell" 
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductItemListFromDB()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProductItemListFromDB()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // get a reference to our storyboard cell
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CartItemCell
        
        obj = objArray[indexPath.row]
        
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
    
    
    func getProductItemListFromDB(){
        let responseObj: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: kProductList)
        do {
            if let results = try self.appDelegate.coreDataStack.managedObjectContext.fetch(responseObj) as? [NSManagedObject] {
                
                let myFavArray: [EntityProductList]? = results as? [EntityProductList]
                
                if myFavArray != nil {
                    self.objArray = myFavArray!
                }
            }
        }
        catch {
            fatalError("There was an error fetching the items")
        }
    }
    
}

