//
//  OTTextFieldExtentions.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 17/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

extension UITextField {
    
    /**
     Adds an image view to the right side of the 
     UITextField to indicate an error in that field
     */
    func indidateError() {
        
        let imageView = UIImageView(image: UIImage(named: "Error"))
        imageView.frame = CGRectMake(0, 0, imageView.image!.size.width + 15.0, imageView.image!.size.height)
        imageView.contentMode = .Center
        
        self.rightView = imageView
        
        self.rightViewMode = .Always
    }
    
    
    /**
     Removes an error indictor in the right part of the textView
     */
    func removeErrorIndidator() {
        
        self.rightView = nil
        self.rightViewMode = .Always
    }
}
