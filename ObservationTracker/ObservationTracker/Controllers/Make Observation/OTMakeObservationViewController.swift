//
//  OTMakeObservationViewController.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 15/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

class OTMakeObservationViewController: UIViewController {

    /// The input form table view controller
    @IBOutlet weak var formTableViewContainerView: UIView!
    
    /// The 'Make Observation' button is made from different components
    @IBOutlet weak var makeObservationButtonLabel: UILabel!
    @IBOutlet weak var makeObservationButton: UIButton!
    @IBOutlet weak var makeObservationImageView: UIImageView!
    
    let SCREEN_TOP : CGFloat = 40.0
    
    var formIsVisable : Bool {
        get {
            return formTableViewContainerView.frame.origin.y == SCREEN_TOP
        }
    }

    @IBAction func makeObservationButtonPressed(sender: AnyObject) {
        if formIsVisable {
            // hide form
        }
        else {
            // show form
            self.makeObservationButtonLabel.hidden = true
            self.makeObservationButton.hidden = true
            self.makeObservationImageView.hidden = true
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.formTableViewContainerView.frame.origin.y = self.SCREEN_TOP
            })
            
        }
    }

}
