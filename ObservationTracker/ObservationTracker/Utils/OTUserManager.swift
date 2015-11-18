//
//  OTUserManager.swift
//  ObservationTracker
//
//  Created by Oliver Poole on 13/11/2015.
//  Copyright © 2015 OliverPoole. All rights reserved.
//

import UIKit

/// A static class responsible for managing the currently signed in user
class OTUserManager {
    
    enum UserDefaultKeys : String {
        case Username = "username"
        case Name = "name"
    }
    
    static let defaults = NSUserDefaults.standardUserDefaults()
    
    
    /**
     Checks if the application already has a user signed in
     
     - returns: True, if there is a user
     */
    static func hasUserAlreadySignedIn() -> Bool {
        let username = defaults.stringForKey(UserDefaultKeys.Username.rawValue)
        
        // check if a username exists
        return username != nil
    }
    
    
    /**
     - returns: The current user, assuming there is one signed in
     */
    static func currentUser() -> OTUser {
        assert(hasUserAlreadySignedIn(), "User is not currently signed in")
        
        let username = defaults.stringForKey(UserDefaultKeys.Username.rawValue)
        let fullName = defaults.stringForKey(UserDefaultKeys.Name.rawValue)
        
        return OTUser(username: username!, fullName: fullName!)
    }
    
    
    /**
     Updates the store with a new user
     
     - parameter user: The new user to add
     */
    static func updateCurrentSignedInUser(user : OTUser) {
        defaults.setObject(user.username, forKey: UserDefaultKeys.Username.rawValue)
        defaults.setObject(user.fullName, forKey: UserDefaultKeys.Name.rawValue)
    }
}
