//
//  StorageManager.swift
//  Psychotype
//
//  Created by mac on 18.01.2021.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    private var context : NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack
    
    private var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Psychotype")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              
           if let error = error as NSError? {
                
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()
    
    
    func saveResult(with type: Type, testName: String){

        let fetchRequest : NSFetchRequest<Result> = Result.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "testName = %@", testName)

        do {
            let array = try context.fetch(fetchRequest)
            if array.count > 0 {
               let existingResult = array[0]
                existingResult.type = type.rawValue
                existingResult.prescription = type.description
                existingResult.specification = ""
            } else {
                guard  let entity = NSEntityDescription.entity(forEntityName: "Result", in: context) else {return}
                   
              let result = Result(entity: entity, insertInto: context)
               
                result.testName = testName
                result.type = type.rawValue
        print(type.rawValue)
                result.prescription = type.description
                result.specification = ""
               // saveContext()
            }
        } catch let error  {
            print(error)

      }

    saveContext()
    
    }
    
    func fetchResult() -> [Result] {
        
        let fetchRequest : NSFetchRequest<Result> = Result.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch let error {
            print(error)
            return []
        }
        
    }
    
    func checkResult(with test: String) -> Bool{
        let fetchRequest : NSFetchRequest<Result> = Result.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "testName = %@", test)

        do {
            let array = try context.fetch(fetchRequest)
            if array.count > 0 {
               return true
            }
        } catch let error {
            print(error)
            return false
        }
        
        return false
        
        }
        
        
    func delete(result: Result) {
        context.delete(result)
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    
  private func saveContext() {
    
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print(nserror, nserror.userInfo)
            }
        }
    }
}
