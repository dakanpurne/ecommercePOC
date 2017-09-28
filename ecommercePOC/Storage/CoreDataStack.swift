//
//  CoreDataStack.swift
//  ecommercePOC
//
//  Created by Dnyaneshwar Kanpurne on 9/27/17.
//  Copyright © 2017 sample. All rights reserved.
//
import Foundation
import CoreData

class CoreDataStack {
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelUrl = Bundle.main.url(forResource: kDataBaseModelName, withExtension: kDataBaseModelExtention)!
        return NSManagedObjectModel(contentsOf: modelUrl)!
    }()
    
    
    lazy var peristentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let applicationDocumentsDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
        let persistentStoreUrl: URL = applicationDocumentsDirectory.appendingPathComponent(kDataBaseSqlLiteUrl)
        
        do {
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
            
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreUrl, options: options)
        }catch {
            fatalError("Persistent store error! \(error)")
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.peristentStoreCoordinator
        
        return managedObjectContext
    }()
    
    func saveContext() {
        if self.managedObjectContext.hasChanges {
            do {
                try self.managedObjectContext.save()
            }
            catch {
                fatalError("There was an error saving the managed object context \(error)")
            }
        }
    }
}
