//
//  OTSignUpViewController.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 01/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

class OTSignUpViewController: UIViewController {
    
    enum TextFieldTags : Int {
        case kUsernameTextField, kFullnameTextField
    }
    
    @IBOutlet weak var startTrackingButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    // Text field entry flags
    var usernameEntered = false
    var fullnameEntered = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a tap gesture recognizer to hide the keyboard when the user clicks the background
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        tapRecognizer.numberOfTapsRequired = 1
        
        view.addGestureRecognizer(tapRecognizer)
        
        startTrackingButton.imageView?.contentMode = .ScaleAspectFit
        startTrackingButton.setImage(UIImage(named: "Tick button"), forState: .Normal)
        
    }
    
    func hideKeyboard() { view.endEditing(true) }
    
    @IBAction func startTrackingButtonPressed(sender: AnyObject) {
        
        let user = OTUser(username: usernameTextField.text!, fullName: fullNameTextField.text!)
        
        OTNetworkInterface.signUp(user.username!, andFullName: user.fullName!) { (success) -> Void in
            
            if success {
                // Login was successful - save the new user
                OTUserManager.updateCurrentSignedInUser(user)
                
                // dismiss the view controller
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            }
            else {
                
                //ERROR
                let alertController = UIAlertController(title: "", message: "Unable to register, username is taken", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.presentViewController(alertController, animated: true, completion: nil)
                })
            }
        }
    }
}

extension OTSignUpViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.tag == TextFieldTags.kUsernameTextField.rawValue {
            // The text field being edited is the username field
            usernameEntered = textField.text != ""
        }
            
        else if textField.tag == TextFieldTags.kFullnameTextField.rawValue {
            // The text field being edited is the full name field
            fullnameEntered = textField.text != ""
        }
        
        startTrackingButton.enabled = usernameEntered && fullnameEntered
    }
    
}
