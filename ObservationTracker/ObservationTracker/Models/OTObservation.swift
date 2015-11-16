//
//  OTObservation.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 16/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit
import MapKit

class OTObservation: NSObject {

    var username : String
    var location : CLLocationCoordinate2D
    var dateTime : NSDate
    
    var obsTitle : String
    var obsDescription : String
    var obsCategory : String
    
    init(username : String, location : CLLocationCoordinate2D, dateTime : NSDate, obsTitle : String, obsDescription : String, obsCategory : String) {
        
        self.username = username
        self.location = location
        self.dateTime = dateTime
        
        self.obsTitle = obsTitle
        self.obsDescription = obsDescription
        self.obsCategory = obsCategory
    }
    
    init(xmlData : OTXMLElement) {
        // do something with the data here
        
        self.username = ""
        self.location = CLLocationCoordinate2DMake(0, 0)
        self.dateTime = NSDate()
        
        self.obsTitle = ""
        self.obsDescription = ""
        self.obsCategory = ""
    }
}
