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
    var distanceFromKabah: Double?
    
    //Provided by Adhan: static let kabah = Coordinates(lat: 21.4225241, lon: 39.8261818)
    static let kabah = Coordinates(lat: 21.422487, lon: 39.826206)
    static let aqsa = Coordinates(lat: 31.7761, lon: 35.2358)
    static let prophet = Coordinates(lat: 24.4707, lon: 39.6307)
    static let ali = Coordinates(lat: 31.9957, lon: 44.3148)
    static let hussain = Coordinates(lat: 32.6164, lon: 44.0324)
    static let reza = Coordinates(lat: 36.2878, lon: 59.6155)
    static let askariain = Coordinates(lat: 34.19878, lon: 43.87338)
    static let baqi = Coordinates(lat: 24.4672, lon: 39.6138)
    static let masuma = Coordinates(lat: 34.6418, lon: 50.8790)
    static let zainab = Coordinates(lat: 33.4444, lon: 36.3409)
    static let test = Coordinates(lat: 41.6528, lon: 83.5379)
    
    static let locations: [(Coordinates, String)] = [
        (.kabah, "Ka'ba"),
        (.aqsa, "Masjid Al-Aqsa"),
        (.prophet, "Masjid Al-Nabawi"),
        (.ali, "Imam Ali Shrine"),
        (.hussain, "Imam Hussain Shrine"),
        (.reza, "Imam Ridha Shrine"),
        (.askariain, "Askarian Shrine"),
        (.baqi, "Baqi'"),
        (.masuma, "Sayedah Ma'suma Shrine"),
        (.zainab, "Sayedah Zainab Shrine"),
        (.test, "Test")
    ]
}

extension Double {
    var degreesToRadians: Double { return self * .pi / 180 }
    var radiansToDegrees: Double { return self * 180 / .pi }
    
    var metersToMiles: Double { return self / 1609.34 }
    var metersToKilometers: Double { return self / 1000 }
}

