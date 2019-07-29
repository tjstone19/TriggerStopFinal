//
//  UserDefaults+isFirstLaunch.swift
//  TriggerStop
//
//  Created by T.J. Stone on 7/28/19.
//  Copyright © 2019 T.J. Stone. All rights reserved.
//

import Foundation

let FIRST_LAUNCH_KEY: String = "firstLaunch"

extension UserDefaults {
    
    
    /**
     * Returns true if this is the first time the user launched the app.
     */
    static func isFirstLaunch() -> Bool {
        let firstLaunch = UserDefaults.standard.object(forKey: FIRST_LAUNCH_KEY)
        
        if firstLaunch == nil {
            return true
        }
        
        return firstLaunch as! Bool
    }
    
    /**
     * Sets the first launch variable to the specified value.
     *
     * @param value: First launch new value.
     */
    static func setFirstLaunch(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: FIRST_LAUNCH_KEY)
    }
}
