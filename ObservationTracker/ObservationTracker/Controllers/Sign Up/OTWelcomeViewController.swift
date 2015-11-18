//
//  OTWelcomeViewController.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 15/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

class OTWelcomeViewController: UIViewController {

    /// The Label at the top of the view controller
    @IBOutlet weak var titleLabel : UILabel!
    
    /// The label for the button at the bottom
    @IBOutlet weak var buttonLabel : UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Check to see if there is a user signed in
        if OTUserManager.hasUserAlreadySignedIn() {
            
            // Display the welcome message
            let user = OTUserManager.currentUser()
            titleLabel.text = "Welcome \(user.username!)"
            
            // Set the button title
            buttonLabel.text = "Start Tracking"
            
        }
        else {
            // ask the user to sign in
            buttonLabel.text = "Sign Up"
        }
    }
    
    
    @IBAction func actionButtonPressed(sender: AnyObject) {
        
        // if user signed in, present tab bar controller
        if OTUserManager.hasUserAlreadySignedIn() {
            let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController")
            
            self.presentViewController(tabBarController!, animated: true, completion: nil)
        }
        else {
            // else present the sign in view controller
            let signupViewController = self.storyboard?.instantiateViewControllerWithIdentifier("OTSignUpViewController")
            self.presentViewController(signupViewController!, animated: true, completion: nil)
        }
    }
}
