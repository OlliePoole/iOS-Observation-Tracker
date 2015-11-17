//
//  OTViewObservationsTableViewController.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 31/10/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit
import MapKit
import QuartzCore

class OTViewObservationsTableViewController: UITableViewController {

    var observations : Array<OTObservation> {
        get {
            let parent = parentViewController as! OTViewObservationViewController!
            return parent.observationsDatasource
        }
    }
    
    func refreshData() {
        // Run the code on the main thread
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - UITableViewDatasource methods
extension OTViewObservationsTableViewController {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return observations.count
    }
    
}

// MARK: - UITableViewDelegate methods
extension OTViewObservationsTableViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OTObservationTableViewCell", forIndexPath: indexPath)
        let observation = observations[indexPath.row]
        
        cell.textLabel?.text = observation.obsTitle
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("OTObservationDetailTableViewController") as! OTObservationDetailTableViewController
        
        detailVC.observation = observations[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
