//
//  OTMakeObservationFormTableViewController.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 01/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit
import MapKit

class OTMakeObservationFormTableViewController: UITableViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateTimeTextField: UITextField!
    
    @IBOutlet weak var observationTitleTextField: UITextField!
    @IBOutlet weak var observationDescriptionTextField: UITextField!
    @IBOutlet weak var observationCategoryTextField: UITextField!
    
    /// The textFields in an un-ordered array
    @IBOutlet var inputTextFields: [UITextField]!
    
    // Only set the user's location once
    var hasSetUsersLocation : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetTextFields()
        
        // Add a tap gesture recognizer to hide the keyboard when the user clicks the background
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        tapRecognizer.numberOfTapsRequired = 1
        
        tableView.addGestureRecognizer(tapRecognizer)
    }
    
    func hideKeyboard() { view.endEditing(true) }
    
}

// MARK: - Submitting the Observation
extension OTMakeObservationFormTableViewController {
    
    @IBAction func makeObservationButtonPressed(sender: AnyObject) {
        
        let observation = observationFromTextFields()
        
        let validForUpload = observation.isValidForUpload()
        
        if validForUpload.isValid {
            // Upload the observation
            OTNetworkInterface.makeObservation(observation, completionHandler: { (success) -> Void in
                
                if success {
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        self.removeErrorIndidators()
                        self.resetTextFields()
                        
                        self.showSuccessHUD(2)
                    }
                }
                else {
                    //ERROR
                    let alertController = UIAlertController(title: "", message: "Unable to upload, username not found", preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                }
            })
        }
        else {
            processErrorsInForm(validForUpload.errorCodes!)
        }
    }
    
    @IBAction func saveForLaterButtonPressed(sender: AnyObject) {
        
        let observation = observationFromTextFields()
        
        let validForUpload = observation.isValidForUpload()
        
        if validForUpload.isValid {
            // Save the observation
            if OTCoreDataManager.saveObservation(observation) {
                // Save successful
                showSuccessHUD(2)
                
                self.removeErrorIndidators()
                self.resetTextFields()
            }
            else {
                // Save failed
                let alertController = UIAlertController(title: "", message: "Unable to save, please try again", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                presentViewController(alertController, animated: true, completion: nil)
            }
        }
        else {
           processErrorsInForm(validForUpload.errorCodes!)
        }
        
    }
    
    func processErrorsInForm(errors : Array<ValidateObjectErrorCode>) {
        // remove the previous error indicators
        removeErrorIndidators()
        
        // Add new indicators to text fields
        for errorCode in errors {
            
            switch errorCode {
            case .username:    usernameTextField.indidateError()
            case .location:    locationTextField.indidateError()
            case .dateTime:    dateTimeTextField.indidateError()
            case .title:       observationTitleTextField.indidateError()
            case .description: observationDescriptionTextField.indidateError()
            case .category:    observationCategoryTextField.indidateError()
            }
        }
    }
    
    func removeErrorIndidators() {
        
        for textField in inputTextFields {
            textField.removeErrorIndidator()
        }
    }
    
    func resetTextFields() {
        
        for textField in inputTextFields {
            textField.text = ""
        }
        
        // Set the default values
        usernameTextField.text = OTUserManager.currentUser().username
        dateTimeTextField.text = NSDate().toString(.UserInterfaceOutput)
        
        hasSetUsersLocation = false
    }
    
    /**
     Reads the UITextFields and builds a OTObservation object
     
     Note: Observation might not be complete
     
     - returns: The observation (see note)
     */
    func observationFromTextFields() -> OTObservation {
        
        var observation = OTObservation()
        // Check the input fields are not empty + create Observation object
        
        if !usernameTextField.text!.isEmpty {
            observation.username = usernameTextField.text!
        }
        
        if let location = locationTextField.text where locationTextField.text?.toCoordinate() != nil {
            observation.location = location.toCoordinate()
        }
        
        if let dateTime = dateTimeTextField.text where dateTimeTextField.text?.toDate() != nil {
            observation.dateTime = dateTime.toDate()
        }
        
        if !observationTitleTextField.text!.isEmpty {
            observation.obsTitle = observationTitleTextField.text!
        }
        
        if !observationDescriptionTextField.text!.isEmpty {
            observation.obsDescription = observationDescriptionTextField.text!
        }
        
        if !observationCategoryTextField.text!.isEmpty {
            observation.obsCategory = observationCategoryTextField.text!
        }
        
        return observation
    }
}

// MARK: - UITextFieldDelegate
extension OTMakeObservationFormTableViewController : UITextFieldDelegate {
    
    /**
     When the user first clicks the location text field,
     a popup is shown asking for the user's current loction
     */
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if !hasSetUsersLocation {
            
            // Get the user's location
            OTUserLocationManager.sharedManager.userLocation { (location) -> Void in
                
                // When the location has been found (not immediate), update the UI
                textField.text = "\(location.latitude.roundToDigits(4)), \(location.longitude.roundToDigits(4))"
                
                // End editing
                textField.resignFirstResponder()
            }
            
            hasSetUsersLocation = true
        }
    }
}
