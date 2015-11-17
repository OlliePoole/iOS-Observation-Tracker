//
//  OTRefineSearchViewController.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 31/10/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

protocol OTRefineSearchDelegate {
    func showAllObservations()
    func refineSearch(sender : OTRefineSearchTableViewController, observationsWithUsername username: String)
    func refineSearch(sender : OTRefineSearchTableViewController, observationsWithCategory category: String)
    func refineSearch(sender : OTRefineSearchTableViewController, observationsWithDateTime dateTime : NSDate)
}

class OTRefineSearchTableViewController: UITableViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    var delegate : OTRefineSearchDelegate!

    @IBAction func allObservationsButtonClicked(sender: AnyObject) {
        delegate?.showAllObservations()
    }
    
    @IBAction func searchByUsernameButtonClicked(sender: AnyObject) {
        let username = usernameTextField.text
        
        if username != "" {
            usernameTextField.resignFirstResponder()
            delegate?.refineSearch(self, observationsWithUsername: username!)
        }
    }
    
    @IBAction func searchByCategoryButtonClicked(sender: AnyObject) {
        let category = categoryTextField.text
        
        if category != "" {
            categoryTextField.resignFirstResponder()
            delegate?.refineSearch(self, observationsWithCategory: category!)
        }
    }

    @IBAction func searchByDateButtonClicked(sender: AnyObject) {
    }
}
