//
//  Conversions.swift
//  Turbah
//
//  Created by MMQ on 7/25/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import Foundation

extension Double {
    var degreesToRadians: Double { return self * .pi / 180 }
    var radiansToDegrees: Double { return self * 180 / .pi }
    
    var metersToMiles: Double { return self / 1609.34 }
    var metersToKilometers: Double { return self / 1000 }
}

extension Float {
    var metersToFeet: Float { return self / 3.28084 }
}
