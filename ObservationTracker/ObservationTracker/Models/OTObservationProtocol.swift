//
//  OTObservationProtocol.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 18/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import Foundation
import MapKit

/**
 *  A protocol responsible for setting the variables
 *  an representation of Observation should have
 */
protocol OTObservationProtocol {
    
    /// The username of the author of the observation
    var username : String? {get set}
    
    /// The location the observation was reported
    var location : CLLocationCoordinate2D? {get set}
    
    /// The dateTime of the observation
    var dateTime : NSDate? {get set}
    
    /// The title given to the observation
    var obsTitle : String? {get set}
    
    /// The description given to the observation
    var obsDescription : String? {get set}
    
    /// The category given to the observation
    var obsCategory : String? {get set}
    
    func isValidForUpload() -> (isValid : Bool, errorCodes : Array<ValidateObjectErrorCode>?)
}


extension OTObservationProtocol {
    
    /**
     Checks the fields to ensure everything is present
     
     - returns: True, if the object is valid for submission.
     If false, an array of error codes for the offending fields
     */
    func isValidForUpload() -> (isValid : Bool, errorCodes : Array<ValidateObjectErrorCode>?) {
        
        var errorCodes = Array<ValidateObjectErrorCode>()
        
        if username == nil       { errorCodes.append(.username) }
        if location == nil       { errorCodes.append(.location) }
        if dateTime == nil       { errorCodes.append(.dateTime) }
        if obsTitle == nil       { errorCodes.append(.title) }
        if obsDescription == nil { errorCodes.append(.description) }
        if obsCategory == nil    { errorCodes.append(.category) }
        
        return (errorCodes.count == 0, errorCodes)
    }
    
}
