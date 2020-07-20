//
//  UserDefaults.swift
//  Turbah
//
//  Created by MMQ on 7/19/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    var northType: Int {
        get {
            return save.integer(forKey: "NorthType")
        }
        set {
            save.set(newValue, forKey: "NorthType")
        }
    }
    
}
