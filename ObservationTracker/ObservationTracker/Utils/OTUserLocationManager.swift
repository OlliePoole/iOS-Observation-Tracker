//
//  OTUserLocationManager.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 17/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit
import MapKit

/// A class responsible for fetching the user's location
class OTUserLocationManager: NSObject {

    static let sharedManager = OTUserLocationManager()
    
    private let locationManager = CLLocationManager()
    
    var locationBlock : ((location : CLLocationCoordinate2D) -> Void)!
    
    func userLocation(locationBlock : (location : CLLocationCoordinate2D) -> Void) {
        
        self.locationBlock = locationBlock
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension OTUserLocationManager : CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        locationBlock(location: newLocation.coordinate)
        
        // Now the location has been updated, stop tracking
        locationManager.stopUpdatingLocation()
    }
}
