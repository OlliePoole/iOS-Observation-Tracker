//
//  OTObservationDetailTableViewController.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 16/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit
import MapKit

class OTObservationDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var observationTitleLabel: UILabel!
    @IBOutlet weak var observationDescriptionLabel: UILabel!
    @IBOutlet weak var observationCategoryLabel: UILabel!
    
    @IBOutlet weak var observationUsernameLabel: UILabel!
    @IBOutlet weak var observationDataTimeLabel: UILabel!
    @IBOutlet weak var observationMapView: MKMapView!
    
    var observation : OTObservationProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = observation.obsTitle
        
        // Set up labels
        observationTitleLabel.text = "Title: \(observation.obsTitle!)"
        observationDescriptionLabel.text = "Description: \(observation.obsDescription!)"
        observationCategoryLabel.text = "Category: \(observation.obsCategory!)"
        
        observationUsernameLabel.text = "Username: \(observation.username!)"
        
        if let dateTime = observation.dateTime {
            observationDataTimeLabel.text = "Date/Time : \(dateTime.toString(.UserInterfaceOutput)!)"
        }
        
        
        // Add annotation to map view
        let annotation = MKPointAnnotation()
        annotation.title = observation.obsTitle
        annotation.coordinate = observation.location!
        
        observationMapView.addAnnotation(annotation)
        
        // Set the camera
        let camera = MKMapCamera()
        camera.centerCoordinate = observation.location!
        camera.altitude = 10000
        
        observationMapView.setCamera(camera, animated: true)
    }
}
