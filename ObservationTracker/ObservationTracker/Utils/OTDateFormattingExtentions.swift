//
//  OTDateFormattingExtentions.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 16/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

// An extention to the NSDate class to provide easy conversion methods
extension NSDate {
    
    func toString() -> String? {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.stringFromDate(self)
    }
    
}

// An extention to the NSString class to convert to date
extension String {
    
    func toDate() -> NSDate? {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.dateFromString(self)
        
    }
    
}
