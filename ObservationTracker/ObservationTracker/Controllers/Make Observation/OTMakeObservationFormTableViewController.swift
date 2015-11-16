//
//  OTMakeObservationFormTableViewController.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 01/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit


class OTMakeObservationFormTableViewController: UITableViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateTimeTextField: UITextField!
    
    @IBOutlet weak var observationTitleTextField: UITextField!
    @IBOutlet weak var observationDescriptionTextField: UITextField!
    @IBOutlet weak var observationCategoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.text = OTUserManager.currentUser().username
        //dateTimeTextField.text = NSDate().
    }
    
    @IBAction func makeObservationButtonPressed(sender: AnyObject) {
    }

    @IBAction func saveForLaterButtonPressed(sender: AnyObject) {
    }

}
