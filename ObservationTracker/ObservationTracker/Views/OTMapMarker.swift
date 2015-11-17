//
//  OTMapMarker.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 16/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit
import MapKit

class OTMapMarker: NSObject, MKAnnotation {

    var title : String?
    var coordinate : CLLocationCoordinate2D
    var observation : OTObservation?
    
    init(title : String, coordinate : CLLocationCoordinate2D, observation : OTObservation) {
        self.title = title
        self.coordinate = coordinate
        self.observation = observation
    }
    
}
