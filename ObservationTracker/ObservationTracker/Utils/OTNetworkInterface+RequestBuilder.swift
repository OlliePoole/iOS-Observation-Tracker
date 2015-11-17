//
//  OTNetworkInterface+RequestBuilder.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 16/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

/**
    An extention to the OTNetworkInterface to provide request
    building functionality.
 */
extension OTNetworkInterface {
    
    /**
     Builds a NSMutableRequest object with a URL and a HTTP Method
     
     - parameter endpoint:   The specific endpoint to append to the base URL
     - parameter httpMethod: The HTTP Method of the request
     
     - returns: The formatted request
     */
    class func requestBuilderWithEndPoint(endpoint: String, httpMethod: String) -> NSMutableURLRequest {
        let url = NSURL(string: baseURL + endpoint)
        let request = NSMutableURLRequest(URL: url!)
        
        request.HTTPMethod = httpMethod
        
        return request
    }
    
    
    /**
     Encodes the parameters of a request to
     
     - parameter params: The parameters for the body of the request
     
     - returns: The HTTP Body in data form to be added to the request
     */
    class func encodedHTTPBodyWithParams(params: Dictionary<String, String>) -> NSData {
        
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
    
    
    /**
     Executes a post request, on completion calls the completion handler
     
     - parameter request:    The request to send
     - parameter httpBody:   The body of the request (params)
     - parameter completion: The completion handler to call on completion
     */
    class func uploadTaskWithRequest(request : NSURLRequest, httpBody : NSData, completion : (success : Bool) -> Void) {
        
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
    
    
    /**
     Exectutes a get request, if successful parses the results and returns them in the completion handler
     
     - parameter request:    The request to exectute
     - parameter completion: The completion handler to call on completion
     */
    class func dataTaskWithRequest(request : NSURLRequest, completion : (success: Bool, results : Array<OTObservation>?) -> Void) {
        
        let sessionTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            let httpURLResponse = response as! NSHTTPURLResponse
            
            if httpURLResponse.statusCode == 200 {
                // Request was successful
                
                // parse the response
                let xmlParser = OTXMLParser()
                let elements = xmlParser.parseXML(data!)
                
                var observations = Array<OTObservation>()
                
                // Check to see if any observations were returned
                if let subElements = elements?.subElements {
                    
                    for observation in subElements {
                        observations.append(OTObservation(xmlData: observation))
                    }
                }
                
                completion(success: true, results: observations)
            }
            else {
                // Request unsuccessful
                completion(success: false, results: nil)
            }
        }
        
        // Start the task
        sessionTask.resume()
    }
}
