//
//  OTMakeObservationViewController.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 01/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

class OTMakeObservationViewController: UIViewController {

    @IBOutlet weak var makeObservationTableViewContainer: UIView!
    var childFormTableViewController : OTMakeObservationFormTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        childFormTableViewController = childViewControllers.first as! OTMakeObservationFormTableViewController
        childFormTableViewController.delegate = self
        
    }

    

}

extension OTMakeObservationViewController : OTMakeObservationFormProtocol {
    func shouldShowForm() {
        // Show the input form
        UIView.animateWithDuration(0.5) { () -> Void in
            self.makeObservationTableViewContainer.frame.origin.y = 0
        }
    }
}