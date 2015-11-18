//
//  ManagedObservation.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 18/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import Foundation
import CoreData
import MapKit

/// A managed observation, suitable for storing in Core Data
class ManagedObservation: NSManagedObject, OTObservationProtocol {

    @NSManaged var username: String?
    
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    
    @NSManaged var dateTime: NSDate?
    
    @NSManaged var obsTitle: String?
    @NSManaged var obsDescription: String?
    @NSManaged var obsCategory: String?
    
    var location : CLLocationCoordinate2D? {
        get {
            return CLLocationCoordinate2DMake(latitude as! Double, longitude as! Double)
        }
        set {}
    }
    
    
    /**
     Copies the contents of an observation into the calling instance
     
     - parameter observation: A class implementing the OTObservationProtocol
     */
    func managedCopy(observation : OTObservationProtocol) {
        
        self.username = observation.username
        
        self.latitude = observation.location?.latitude
        self.longitude = observation.location?.longitude
        
        self.dateTime = observation.dateTime
        
        self.obsTitle = observation.obsTitle
        self.obsDescription = observation.obsDescription
        self.obsCategory = observation.obsCategory
    }
}
