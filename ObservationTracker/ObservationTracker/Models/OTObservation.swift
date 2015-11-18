//
//  OTObservation.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 16/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit
import MapKit

enum ValidateObjectErrorCode {
    case username, location, dateTime, title, description, category
}

/// A non-managed implementation of OTObservationProtocol
struct OTObservation : OTObservationProtocol {
    
    var username : String?
    var location : CLLocationCoordinate2D?
    var dateTime : NSDate?
    
    var obsTitle : String?
    var obsDescription : String?
    var obsCategory : String?
    
    init() {}
    
    init(username : String, location : CLLocationCoordinate2D, dateTime : NSDate, obsTitle : String, obsDescription : String, obsCategory : String) {
        
        self.username = username
        self.location = location
        self.dateTime = dateTime
        
        self.obsTitle = obsTitle
        self.obsDescription = obsDescription
        self.obsCategory = obsCategory
    }
    
    /**
     Initalises a new OTObservation object using an XML element
     
     - parameter xmlData: The formatted xml element in OTXMLElement form
     
     - returns: The initalised object
     */
    init(xmlData : OTXMLElement) {
        
        var latitude : Double = 0.0
        var longtitude : Double = 0.0
        
        for element in xmlData.subElements {
            
            switch element.name {
                
                case "username":
                    if let username = element.text {
                        self.username = username
                    }
                    else {
                        username = ""
                    }
                    
                case "latitude" :
                    latitude = Double(element.text!)!
                    
                case "longitude" :
                    longtitude = Double(element.text!)!
                    
                case "date":
                    
                    // Some of the dates are nil
                    if let formattedDate = element.text.toDate() {
                        self.dateTime = formattedDate
                    }
                    
                case "name":
                    if let title = element.text {
                        obsTitle = title
                    }
                    else {
                        obsTitle = ""
                    }
                
                case "description":
                    if let description = element.text {
                        obsDescription = description
                    }
                    else {
                        obsDescription = ""
                    }
                
                case "category":
                    if let category = element.text {
                        obsCategory = category
                    }
                    else {
                        obsCategory = ""
                    }
                
                default:
                    ()
                
            }
        }
        self.location = CLLocationCoordinate2DMake(latitude, longtitude)
    }
    
}