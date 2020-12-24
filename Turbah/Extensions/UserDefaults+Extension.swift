//
//  UserDefaults+Extension.swift
//  Turbah
//
//  Created by MMQ on 7/19/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    var trueNorth: Bool {
        get {
            return save.bool(forKey: "NorthType")
        }
        set {
            save.set(newValue, forKey: "NorthType")
        }
    }
    
    var distance: Float {
        get {
            return save.float(forKey: "TurbahDistance")
        }
        set {
            save.set(newValue, forKey: "TurbahDistance")
        }
    }
    
    
    var didRerunTutorial: Bool {
        get {
            return save.bool(forKey: "DidFirstARViewConfigRerun")
        }
        set {
            save.set(newValue, forKey: "DidFirstARViewConfigRerun")
        }
    }
    
    var didShowCalibration: Bool {
        get {
            return save.bool(forKey: "DidShowCalibrationTutorial")
        }
        set {
            save.set(newValue, forKey: "DidShowCalibrationTutorial")
        }
    }
    
}
