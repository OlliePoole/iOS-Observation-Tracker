//
//  OTSuccessHUD.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 18/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import Foundation
import UIKit

protocol OTSuccessHUDProtocol {
    
    func showSuccessHUD(duration: Double)
}

/// An extention to UIViewController to add functionality to display a success HUD
extension UIViewController : OTSuccessHUDProtocol {
    
    func showSuccessHUD(duration: Double) {
        
        // Add the success image
        let hudImageView = UIImageView(image: UIImage(named: "Success HUD"))
        hudImageView.contentMode = .Center
        hudImageView.center = view.center
        
        // Darken the background of the view
        let darkenedView = UIView(frame: view.frame)
        darkenedView.backgroundColor = UIColor.blackColor()
        darkenedView.alpha = 0.75
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.view.addSubview(darkenedView)
            self.view.addSubview(hudImageView)
        }
        
        // Wait for the duration seconds, then remove the HUD
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(duration * Double(NSEC_PER_SEC))),
            dispatch_get_main_queue(), { () -> Void in
                
                hudImageView.removeFromSuperview()
                darkenedView.removeFromSuperview()
        })
    }
}