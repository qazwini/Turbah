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
    
    static let locations: [Coordinates] = [.kabah, .aqsa, .prophet, .ali, .hussain, .reza, .askariain, .baqi, .masuma, .zainab]
}
