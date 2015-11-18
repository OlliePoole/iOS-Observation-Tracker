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
    
    // Child view controllers
    var mapViewController : OTViewObservationMapViewController!
    var listViewTableViewController : OTViewObservationsTableViewController!
    var refineSearchTableViewController : OTRefineSearchTableViewController!
    
    var refineSearchToggled = false
    
    var observationsDatasource : Array<OTObservationProtocol>! = Array()
    
    /// A single completion handler for all network requests for the view controller
    var requestCompletionHandler : ((success : Bool, results : Array<OTObservationProtocol>?) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate of the refine search view
        refineSearchTableViewController.delegate = self
        
        /**
        *  For every network request the view controller sends the completion handler
        *  is the same. So to avoid duplicating code, it's defined here.
        */
        requestCompletionHandler = { (success : Bool, results : Array<OTObservationProtocol>?) -> Void in
            if success {
                self.observationsDatasource = results
                
                self.mapViewController.refreshData()
                self.listViewTableViewController.refreshData()
            }
            else {
                let alertController = UIAlertController(title: "Error", message: "Something isn't quite right, check the search again", preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                
                // Ask the main thread to display the alert
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
        }
        
        // Load the first set of observations
        OTNetworkInterface.fetchObservations(requestCompletionHandler)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch segue.identifier! {
            
            case "OTViewObservationMapViewController":
                mapViewController = segue.destinationViewController as! OTViewObservationMapViewController
                
            case "OTViewObservationsTableViewController":
                listViewTableViewController = segue.destinationViewController as! OTViewObservationsTableViewController
                
            case "OTRefineSearchTableViewController":
                refineSearchTableViewController = segue.destinationViewController as! OTRefineSearchTableViewController
                
            default:
                ()
        }
    }
}

// MARK: - UI Interactions
extension OTViewObservationViewController {
    
    @IBAction func segmentControlValueChanged(sender: AnyObject) {
        // Toggle the views
        mapViewControllerContainerView.hidden = !mapViewControllerContainerView.hidden
        tableViewControllerContainerView.hidden = !tableViewControllerContainerView.hidden
    }
    
    @IBAction func refineSearchButtonClicked(sender: AnyObject) {
        toggleRefineSearchViewController()
    }
    
    
    /**
     Based on the current state of the search controller,
     the method either shows it or hides it.
     */
    func toggleRefineSearchViewController() {
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
                self.refineSearchControllerContainerView.frame.origin.y = 40
                },
                completion: { (completed) -> Void in
                    self.refineSearchToggled = true
            })
        }
    }
}


// MARK: - OTRefineSearchDelegate
extension OTViewObservationViewController : OTRefineSearchDelegate {
    
    func showAllObservations() {
        toggleRefineSearchViewController()
        
        OTNetworkInterface.fetchObservations(requestCompletionHandler)
    }
    
    func refineSearch(sender: OTRefineSearchTableViewController, observationsWithUsername username: String) {
        toggleRefineSearchViewController()
        
        OTNetworkInterface.fetchObservations(madeByUser: username, completion: requestCompletionHandler)
    }
    
    func refineSearch(sender : OTRefineSearchTableViewController, observationsWithCategory category: String) {
        toggleRefineSearchViewController()
        
        OTNetworkInterface.fetchObservations(matchingCategory: category, completion: requestCompletionHandler)
    }
    
    func refineSearch(sender: OTRefineSearchTableViewController, observationsWithDateTime dateTime: NSDate) {
        toggleRefineSearchViewController()
        
        OTNetworkInterface.fetchObservations(since: dateTime, completion: requestCompletionHandler)
    }
}
