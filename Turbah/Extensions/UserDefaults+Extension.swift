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
            return save.bool(forKey: SaveKeys.NorthType)
        }
        set {
            save.set(newValue, forKey: SaveKeys.NorthType)
        }
    }
    
    var distance: Float {
        get {
            return save.float(forKey: SaveKeys.TurbahDistance)
        }
        set {
            save.set(newValue, forKey: SaveKeys.TurbahDistance)
        }
    }
    
    
    var didRerunTutorial: Bool {
        get {
            return save.bool(forKey: SaveKeys.DidFirstARViewConfigRerun)
        }
        set {
            save.set(newValue, forKey: SaveKeys.DidFirstARViewConfigRerun)
        }
    }
    
    var didShowCalibration: Bool {
        get {
            return save.bool(forKey: SaveKeys.DidShowCalibrationTutorial)
        }
        set {
            save.set(newValue, forKey: SaveKeys.DidShowCalibrationTutorial)
        }
    }
    
    enum SaveKeys {
        static let NorthType = "NorthType"
        static let TurbahDistance = "TurbahDistance"
        static let DidFirstARViewConfigRerun = "DidFirstARViewConfigRerun"
        static let DidShowCalibrationTutorial = "DidShowCalibrationTutorial"
    }
    
}
