//
//  OTNetworkInterfaceProtocol.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 17/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import Foundation

protocol OTNetworkInterfaceProtocol {
    
    // Sign the user up
    static func signUp(username : String, andFullName fullname: String, completionHandler completion : (success : Bool) -> Void)
    
    // Upload an observation
    static func makeObservation(observation : OTObservationProtocol, completionHandler completion : (success : Bool) -> Void)
    
    // Fetch all the observatons
    static func fetchObservations(completion : (success : Bool, results : Array<OTObservationProtocol>?) -> Void)
    
    // Observations made by a specified user
    static func fetchObservations(madeByUser username : String, completion : (success : Bool, results : Array<OTObservationProtocol>?) -> Void)
    
    // Observations since a date
    static func fetchObservations(since date : NSDate, completion : (success : Bool, results : Array<OTObservationProtocol>?) -> Void)
    
    // Obsevations matches a category
    static func fetchObservations(matchingCategory category : NSString, completion : (success : Bool, results : Array<OTObservationProtocol>?) -> Void)
}