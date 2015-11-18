//
//  OTSavedObservationsTableViewController.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 18/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

class OTSavedObservationsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var datasource = Array<ManagedObservation>()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        refreshTable()
    }
    
    func refreshTable() {
        datasource = OTCoreDataManager.fetchSavedObservations()!
        
        // If there's no observations, hide the tableview
        tableView.hidden = datasource.count == 0
        
        // If there are observations, hide the image view
        backgroundImageView.hidden = datasource.count != 0
        
        tableView.reloadData()
    }
}


extension OTSavedObservationsViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OTSavedObservationTableViewCell", forIndexPath: indexPath)
        let observation = datasource[indexPath.row]
        
        cell.textLabel?.text = observation.obsTitle
        
        return cell
    }
}

extension OTSavedObservationsViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let observation = datasource[indexPath.row]
        
        // Show an action sheet, with three options
        // 1. Show details about the Observation
        // 2. Upload the observation
        // 3. Delete the observation
        
        let alertController = UIAlertController(title: "Actions Available", message: "", preferredStyle: .ActionSheet)
        
        
        /**
        *  Presents the detail view controller and shows the observation
        */
        alertController.addAction(UIAlertAction(title: "Show details", style: .Default, handler: { (action) -> Void in
            let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("OTObservationDetailTableViewController") as! OTObservationDetailTableViewController
            
            detailVC.observation = observation
            
            self.navigationController?.pushViewController(detailVC, animated: true)
        }))
        
        
        /**
        *  Add an upload action:
        *       Handles the response of the upload request
        *       Refreshes the tableView
        */
        alertController.addAction(UIAlertAction(title: "Upload", style: .Default, handler: { (action) -> Void in
            
            OTNetworkInterface.makeObservation(observation, completionHandler: { (success) -> Void in
                if success {
                    OTCoreDataManager.deleteObservation(observation)
                    
                    dispatch_async(dispatch_get_main_queue()) { () -> Void in
                        self.showSuccessHUD(2)
                        self.refreshTable()
                    }
                }
                else {
                    // Sow error HUD
                    let alertController = UIAlertController(title: "", message: "Unable to upload, username not found", preferredStyle: .Alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.presentViewController(alertController, animated: true, completion: nil)
                    })
                }
            })
        }))
        
        
        /**
        *  Deletes the observation and refreshes the table view
        */
        alertController.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: { (action) -> Void in
            OTCoreDataManager.deleteObservation(observation)
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.refreshTable()
            }
        }))
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}