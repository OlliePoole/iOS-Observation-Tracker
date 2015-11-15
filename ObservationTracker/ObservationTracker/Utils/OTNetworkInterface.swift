//
//  OTNetworkInterface.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 31/10/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import Foundation

class OTNetworkInterface {
    
    static let baseURL = "http://sots.brookes.ac.uk/~p0073862/services/obs"
    
    static func signUpWithUsername(username : String, andFullName fullname: String, withCompletionHandler completion : (success : Bool) -> Void) {
        
        let request = requestBuilderWithEndPoint("/register", httpMethod: "POST")
        
        var params : Dictionary<String, String> = Dictionary()
            
        params["username"] = username
        params["name"] = fullname
        
        let httpBody = encodedHTTPBodyWithParams(params)
        
        let session = NSURLSession.sharedSession()
        
        let sessionTask = session.uploadTaskWithRequest(request, fromData: httpBody) { (data, response, error) -> Void in
            let httpURLResponse = response as! NSHTTPURLResponse
            
            if httpURLResponse.statusCode == 200 {
                // Request was successful
                completion(success: true)
            }
            else {
                // Request unsuccessful
                completion(success: false)
            }
        }
        
        // Start the task
        sessionTask.resume()
    }
    
    
    private static func requestBuilderWithEndPoint(endpoint: String, httpMethod: String) -> NSMutableURLRequest {
        let url = NSURL(string: baseURL + endpoint)
        let request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = httpMethod
        
        return request
    }
    
    
    private static func encodedHTTPBodyWithParams(params: Dictionary<String, String>) -> NSData {
        
        var requestBody = ""
        var paramCount = 0
        
        for (key, value) in params {
            requestBody += key + "=" + value
            
            paramCount++
            
            if paramCount < params.count {
                requestBody += "&"
            }
        }
        
        return requestBody.dataUsingEncoding(NSUTF8StringEncoding)!
    }
}
