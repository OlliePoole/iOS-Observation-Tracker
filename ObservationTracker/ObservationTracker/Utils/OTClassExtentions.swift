//
//  OTDateFormattingExtentions.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 16/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit
import MapKit

/**
 Enum storing date formater strings
 */
enum DateStringFormat : String {
    /// Use when converting a date to draw on the screen
    case UserInterfaceOutput = "dd-MM-yyyy HH:mm:ss"
    
    /// Use when converting a date to use in a network request
    case NetworkRequest = "YYYYMMdd'T'HHmmss"
    
    /// Use when converting from XML String to NSDate
    case XMLConversion = "yyyy-MM-dd HH:mm:ss"
}

// An extention to the NSDate class to convert to a string
extension NSDate {
    
     /**
     Converts a date to a formatted string
     
     - parameter format: The format the converted date should be in
     
     - returns: The formatted string, nil if the string could not be converted
     */
    func toString(format : DateStringFormat) -> String? {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format.rawValue
        
        return dateFormatter.stringFromDate(self)
    }
}

// An extention to the NSString class to convert to date
extension String {
    
    /**
     Converts a formatted string into the date it represents
     
     - returns: The formatted date, nil if the string could not be converted
     */
    func toDate() -> NSDate? {
        
        let dateFormatter = NSDateFormatter()
        
        for dateFormat in [DateStringFormat.UserInterfaceOutput, .NetworkRequest, .XMLConversion] {
            
            dateFormatter.dateFormat = dateFormat.rawValue
            
            // Check if the date converts successfully
            if let formattedDate = dateFormatter.dateFromString(self) {
                return formattedDate
            }
        }
        
        return nil
    }
    
    
    /**
     Converts a string coordinate ("Double, Double") into a coordinate object
     
     - returns: The coordinate object, nil if the string is not valid
     */
    func toCoordinate() -> CLLocationCoordinate2D? {
        
        let coordinates = self.componentsSeparatedByString(", ")
        
        if coordinates.count == 2 { // lat and long
            
            // ensure the 'coordinates' convert to Double
            if let lat = Double(coordinates[0]) {
                
                if let long = Double(coordinates[1]) {
                    let coordinate = CLLocationCoordinate2DMake(lat, long)
                    
                    // ensure coordinate is valid
                    if CLLocationCoordinate2DIsValid(coordinate) {
                        return coordinate
                    }
                }
            }
        }
        
        // If the string is not valid coordinates, return nil
        return nil
    }
}

// An extention to the Double class to include a rounding operation
extension Double {
    
    /**
     Rounds a double to a given number of decimal places
     
     - parameter places: The number of places to round to
     
     - returns: The rounded double
     */
    func roundToDigits(places : Int) -> Double {
        
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}
