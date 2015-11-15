//
//  OTMakeObservationFormTableViewController.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 01/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

protocol OTMakeObservationFormProtocol {
    func shouldShowForm()
}

class OTMakeObservationFormTableViewController: UITableViewController {

    var delegate : OTMakeObservationFormProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func makeObservationButtonPressed(sender: AnyObject) {
        delegate?.shouldShowForm()
    }

}
