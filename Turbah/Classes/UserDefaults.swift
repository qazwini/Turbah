//
//  UserDefaults.swift
//  Turbah
//
//  Created by MMQ on 7/19/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum northTypeEnum { case trueNorth, magneticNorth }
    var northType: northTypeEnum {
        get {
            return (save.integer(forKey: "NorthType") == 0) ? .trueNorth : .magneticNorth
        }
        set {
            save.set((newValue == .trueNorth) ? 0 : 1, forKey: "NorthType")
        }
    }
    
}
