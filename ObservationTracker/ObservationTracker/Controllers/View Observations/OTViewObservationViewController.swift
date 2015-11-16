//
//  OTViewObservationViewController.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 31/10/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

class OTViewObservationViewController: UIViewController {

    // Containers
    @IBOutlet weak var mapViewControllerContainerView: UIView!
    @IBOutlet weak var tableViewControllerContainerView: UIView!
    @IBOutlet weak var refineSearchControllerContainerView: UIView!
    
    var refineSearchToggled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OTNetworkInterface.fetchAllObservationsWithCompletionHandler { (success, results) -> Void in
            print(results)
        }
    }
    
    @IBAction func segmentControlValueChanged(sender: AnyObject) {
        // Toggle the views
        mapViewControllerContainerView.hidden = !mapViewControllerContainerView.hidden
        tableViewControllerContainerView.hidden = !tableViewControllerContainerView.hidden
    }
    
    @IBAction func refineSearchButtonClicked(sender: AnyObject) {
        if refineSearchToggled {
            // Hide the view
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.refineSearchControllerContainerView.frame.origin.y = -700
                },
                completion: { (completed) -> Void in
                    self.refineSearchToggled = false
            })
        }
        else {
            // Show the view
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.refineSearchControllerContainerView.frame.origin.y = 0
                },
                completion: { (completed) -> Void in
                    self.refineSearchToggled = true
            })
        }
    }
}
