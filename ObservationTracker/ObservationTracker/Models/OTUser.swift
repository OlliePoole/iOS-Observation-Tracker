//
//  OTUser.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 13/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

class OTUser: NSObject {

    var username : String?
    var fullName : String?
    
    init(username: String, fullName: String) {
        self.username = username
        self.fullName = fullName
    }
}
