//
//  OTNetworkInterface.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 31/10/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import Foundation

class OTNetworkInterface : OTNetworkInterfaceProtocol {
    
    /// The base url of the web service
    static let baseURL = "http://sots.brookes.ac.uk/~p0073862/services/obs"
    
    /// The shared url session manager that handles requests
    static let session = NSURLSession.sharedSession()
    
    
    /**
     Sends a request to register the user with the web service
     
     - parameter username:   The username to use
     - parameter fullname:   The full name of the user
     - parameter completion: The completion handler called on completion
     */
    static func signUp(username : String, andFullName fullname: String, completionHandler completion : (success : Bool) -> Void) {
        
        let request = requestBuilder(endpoint: "/register", httpMethod: "POST")
        
        var params : Dictionary<String, String> = Dictionary()
        
        params["username"] = username
        params["name"] = fullname
        
        let httpBody = encodedHTTPBody(params)
        
        // Send the request
        uploadTask(request, httpBody: httpBody, completion: completion)
    }
    
    
    /**
     Uploads an observation to the web service
     
     - parameter observation: The observation to upload. Must implement the OTObservationProtocol
     - parameter completion:  The completion handler for the request
     */
    static func makeObservation(observation : OTObservationProtocol, completionHandler completion : (success : Bool) -> Void) {
        assert(observation.isValidForUpload().isValid, "Observation is not valid for upload")
        
        let request = requestBuilder(endpoint:"/observations", httpMethod: "POST")
        
        var params = Dictionary<String, String>()
        
        params["username"] = observation.username
        params["name"] = observation.obsTitle
        params["description"] = observation.obsDescription
        params["date"] = observation.dateTime?.toString(.NetworkRequest)
        params["latitude"] = String(observation.location!.latitude)
        params["longitude"] = String(observation.location!.longitude)
        params["category"] = observation.obsCategory
        
        let httpBody = encodedHTTPBody(params)
        
        uploadTask(request, httpBody: httpBody, completion: completion)
    }
    
    
    /**
     Fetches all the observations
     
     - parameter completion: The completion handler
     - parameter results:    The results of the request
     */
    static func fetchObservations(completion : (success : Bool, results : Array<OTObservationProtocol>?) -> Void) {
        let request = requestBuilder(endpoint:"/observations", httpMethod: "GET")
        
        dataTask(request, completion: completion)
    }
    
    
    /**
     Fetches all the observations that where made by a specified user
     
     - parameter username:   The username of the user to search for
     - parameter completion: The completion handler
     - parameter results:    The results of the search
     */
    static func fetchObservations(madeByUser username: String, completion: (success: Bool, results: Array<OTObservationProtocol>?) -> Void) {
        
        let request = requestBuilder(endpoint:"/observations/user/\(username)", httpMethod: "GET")
        
        dataTask(request, completion: completion)
    }
    
    
    /**
     Fetches all the observations made after the date specified
     
     - parameter date:       The unformatted NSDate
     - parameter completion: The completion handler
     */
    static func fetchObservations(since date: NSDate, completion: (success: Bool, results: Array<OTObservationProtocol>?) -> Void) {
        
        let request = requestBuilder(endpoint:"/observations/since/\(date.toString(.NetworkRequest)!)", httpMethod: "GET")
        
        dataTask(request, completion: completion)
    }
    
    
    /**
     Fetches all the observations tagged with a specific category
     
     - parameter category:   The category to search for
     - parameter completion: The completion handler
     */
    static func fetchObservations(matchingCategory category: NSString, completion: (success: Bool, results: Array<OTObservationProtocol>?) -> Void) {

        let request = requestBuilder(endpoint:"/observations/category/\(category)", httpMethod: "GET")
        
        dataTask(request, completion: completion)
    }
}




