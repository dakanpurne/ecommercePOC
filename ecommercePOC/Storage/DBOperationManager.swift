//
//  DBOperationManager.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/27/17.
//  Copyright © 2017 sample. All rights reserved.
//

import UIKit
import CoreData

//CRUD Operations
class DBOperationManager {
    
    //AppDelegate instance
    var appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //method to check duplicate entry from core data
    func checkDuplicate(entity:String,column:String,value:String) -> Bool{
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let predicate = NSPredicate(format: column + " = %@" , value)
        fetchRequest.predicate = predicate
        do{
            let fetchResult = try self.appDelegate.coreDataStack.managedObjectContext.fetch(fetchRequest)
            if fetchResult.count == 0 {
                return true
            }else{
                return false
            }
        }catch{
            fatalError("There was an error fetching the items")
        }
        return false
    }
    
    //method to get records by id from database
    func getRecordsById(entity:String,column:String,value:String)-> Any {
        let fetchRequest: NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let predicate = NSPredicate(format: column + " = %@" , value)
        fetchRequest.predicate = predicate
        do{
            let fetchResult = try self.appDelegate.coreDataStack.managedObjectContext.fetch(fetchRequest)
            
            return fetchResult
        }catch{
            fatalError("There was an error fetching the items")
        }
    }
    
    //method to batach delete data
    func batchDeleteEntitiesFromDB(entity:String)  {
        
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: entity))
        do {
            try appDelegate.coreDataStack.managedObjectContext.execute(DelAllReqVar)
        }catch {
            debugPrint(error)
        }
    }
}
