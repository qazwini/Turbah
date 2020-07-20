//
//  Coordinates.swift
//  Turbah
//
//  Created by MMQ on 7/17/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import Foundation

struct Coordinates {
    let lat: Double
    let lon: Double
}

enum Locations: String {
    case kabah = "Ka'ba"
    case aqsa = "Masjid Al-Aqsa"
    case prophet = "Masjid Al-Nabawi"
    case ali = "Imam Ali Shrine"
    case hussain = "Imam Hussain Shrine"
    case reza = "Imam Ridha Shrine"
    case askariain = "Askarian Shrine"
    case baqi = "Baqi'"
    case masuma = "Sayedah Ma'suma Shrine"
    case zainab = "Sayedah Zainab Shrine"
    case test = "Test"
    
    var coodinates: Coordinates {
        switch self {
        //Adhan's coordinates for Kabah: Coordinates(lat: 21.4225241, lon: 39.8261818)
        case .kabah: return Coordinates(lat: 21.422487, lon: 39.826206)
        case .aqsa: return Coordinates(lat: 31.7761, lon: 35.2358)
        case .prophet: return Coordinates(lat: 24.4707, lon: 39.6307)
        case .ali: return Coordinates(lat: 31.9957, lon: 44.3148)
        case .hussain: return Coordinates(lat: 32.6164, lon: 44.0324)
        case .reza: return Coordinates(lat: 36.2878, lon: 59.6155)
        case .askariain: return Coordinates(lat: 34.19878, lon: 43.87338)
        case .baqi: return Coordinates(lat: 24.4672, lon: 39.6138)
        case .masuma: return Coordinates(lat: 34.6418, lon: 50.8790)
        case .zainab: return Coordinates(lat: 33.4444, lon: 36.3409)
        case .test: return Coordinates(lat: 41.6528, lon: 83.5379)
        }
    }
}

extension Double {
    var degreesToRadians: Double { return self * .pi / 180 }
    var radiansToDegrees: Double { return self * 180 / .pi }
    
    var metersToMiles: Double { return self / 1609.34 }
    var metersToKilometers: Double { return self / 1000 }
}
