//
//  OTViewObservationMapViewController.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 31/10/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit
import MapKit

class OTViewObservationMapViewController: UIViewController {
    
    @IBOutlet weak var mapView : MKMapView!
    
    /// The map markers
    var markers = Array<OTMapMarker>()
    
    var observations : Array<OTObservation> {
        get {
            let parent = parentViewController as! OTViewObservationViewController!
            return parent.observationsDatasource
        }
    }
    
    func refreshData() {
        // Run the code on the main thread
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.plotMapMarkers()
        }
    }
    
    func plotMapMarkers() {
        // Remove old markers
        mapView.removeAnnotations(markers)
        markers = Array<OTMapMarker>()
        
        // Add a marker to the map for each observation
        for observation in observations {
            let marker = OTMapMarker(title: observation.obsTitle, coordinate: observation.location, observation: observation)
            
            markers.append(marker)
        }
        
        mapView.addAnnotations(markers)
    }
}

extension OTViewObservationMapViewController : MKMapViewDelegate {
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKindOfClass(OTMapMarker) {
            let identifer = "OTMapMarker"
            
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifer)
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation:annotation, reuseIdentifier:identifer)
                annotationView!.canShowCallout = true
                
                let calloutButton = UIButton(type: .DetailDisclosure)
                annotationView!.rightCalloutAccessoryView = calloutButton
                
            } else {
                annotationView!.annotation = annotation
            }
            
            return annotationView
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        let detailVC = storyboard?.instantiateViewControllerWithIdentifier("OTObservationDetailTableViewController") as! OTObservationDetailTableViewController
        
        detailVC.observation = (view.annotation as! OTMapMarker).observation
        
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
}