//
//  OTNetworkInterface.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 31/10/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import Foundation

class OTNetworkInterface {
    
    /// The base url of the web service
    static let baseURL = "http://sots.brookes.ac.uk/~p0073862/services/obs"
    
    /// The shared url session manager that handles requests
    static let session = NSURLSession.sharedSession()
    
    
    /**
     Sends a request to sign a new user up
     
     - parameter username:   The username to use
     - parameter fullname:   The fullname to use
     - parameter completion: The completion handler to call when the request is completed
     */
    static func signUpWithUsername(username : String, andFullName fullname: String, withCompletionHandler completion : (success : Bool) -> Void) {
        
        let request = requestBuilderWithEndPoint("/register", httpMethod: "POST")
        
        var params : Dictionary<String, String> = Dictionary()
        
        params["username"] = username
        params["name"] = fullname
        
        let httpBody = encodedHTTPBodyWithParams(params)
        
        // Send the request
        uploadTaskWithRequest(request, httpBody: httpBody, completion: completion)
    }
    
    /**
     Makes an observation
     
     - parameter observation: The observation to make
     - parameter completion:  The completion handler to call on completion
     */
    static func makeObservationWithObservation(observation : OTObservation, withCompletionHandler completion : (success : Bool) -> Void) {
        let request = requestBuilderWithEndPoint("/observations", httpMethod: "POST")
        
        //TODO: Sort params here
        
        uploadTaskWithRequest(request, httpBody: NSData(), completion: completion)
    }
    
    
    /**
     Fetches all the observations
     
     - parameter completion: The completion handler called when the request is completed
     */
    static func fetchAllObservationsWithCompletionHandler(completion : (success : Bool, results : Array<OTObservation>?) -> Void) {
        let request = requestBuilderWithEndPoint("/observations", httpMethod: "GET")
        
        dataTaskWithRequest(request, completion: completion)
    }
    
    
    /**
     Fetches all the observations made by a specific user
     
     - parameter username:   The username of the user to search for
     - parameter completion: The completion handler
     */
    static func fetchObservationsMadeByUserWithUsername(username : String, completion : (success : Bool, results : Array<OTObservation>?) -> Void) {
        let request = requestBuilderWithEndPoint("/observations/user/\(username)", httpMethod: "GET")
        
        dataTaskWithRequest(request, completion: completion)
    }
    
    
    /**
     Fetches all the observations made after the date specified
     
     - parameter date:       The unformatted NSDate
     - parameter completion: The completion handler
     */
    static func fetchObservationsSince(date : NSDate, completion : (success : Bool, results : Array<OTObservation>?) -> Void) {
        //TODO: Format the date/time string here
        let request = requestBuilderWithEndPoint("/observations/since/datetime", httpMethod: "GET")
        
        dataTaskWithRequest(request, completion: completion)
    }
    
    
    /**
     Fetches all the observations tagged with a specific category
     
     - parameter category:   The category to search for
     - parameter completion: The completion handler
     */
    static func fetchObservationsForCategory(category : NSString, completion : (success : Bool, results : Array<OTObservation>?) -> Void) {
        let request = requestBuilderWithEndPoint("/observations/category/\(category)", httpMethod: "GET")
        
        dataTaskWithRequest(request, completion: completion)
    }
}




