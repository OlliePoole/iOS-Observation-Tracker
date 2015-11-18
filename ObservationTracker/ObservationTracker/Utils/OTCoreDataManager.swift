//
//  CoreDataManager.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 18/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/// A class responsible for saving and loading from core data
class OTCoreDataManager {
    
    private static let EntityName = "ManagedObservation"
    
    private static var managedObjectContext : NSManagedObjectContext! {
        get {
            return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        }
    }
    
    /**
     Fetches any saved observations
     
     - returns: The observations, if any
     */
    static func fetchSavedObservations() -> Array<ManagedObservation>? {
        
        let fetchRequest = NSFetchRequest(entityName: EntityName)
        fetchRequest.returnsObjectsAsFaults = false
        
        var results = Array<ManagedObservation>()
        
        do {
            results = try managedObjectContext!.executeFetchRequest(fetchRequest) as! [ManagedObservation]
        }
        catch {
            print(error)
        }
        
        return results
    }
    
    
    /**
     Saves an observation
     
     - parameter observation: The observation to save
     
     - returns: True if the save was successful
     */
    static func saveObservation(observation : OTObservationProtocol) -> Bool {
        
        // Create a new Managed Observation
        let managedObservation = NSEntityDescription.insertNewObjectForEntityForName(EntityName, inManagedObjectContext: managedObjectContext) as! ManagedObservation
        
        // Copy the contents of the OTObservation to the Managed Observation
        managedObservation.managedCopy(observation)
        
        return saveContext()
    }
    
    
    /**
     Deletes the ManagedObservation from the core data instance
     
     - parameter observation: The observation to delete
     */
    static func deleteObservation(observation : ManagedObservation) {
        managedObjectContext.deleteObject(observation)
        saveContext()
    }
    
    /**
     Saves the current context of Core Data
     
     - returns: True if the save was successful
     */
    private static func saveContext() -> Bool {
        do {
            if let managedObjectContext = managedObjectContext {
                if managedObjectContext.hasChanges {
                    try managedObjectContext.save()
                    return true
                }
            }
        }
        catch {
            print(error)
        }
        
        return false
    }
}