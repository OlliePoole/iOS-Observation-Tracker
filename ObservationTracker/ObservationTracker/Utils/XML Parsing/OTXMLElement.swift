//
//  OTXMLElement.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 16/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

class OTXMLElement: NSObject {
    
    var name : String!
    var text : String!
    var attributes : Dictionary<String, String>!
    var parent : OTXMLElement!
    
    var subElements : Array<OTXMLElement>!
    
}
