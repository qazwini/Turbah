//
//  Location.swift
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

enum Locations {
    case kabah
    case prophet
    case aqsa
    case baqi
    case ali
    case hussain
    case reza
    case askariain
    case masuma
    case zainab
    
    case iia
    
    case top
    case right
    case bottom
    case left
    
    static let allLocations: [Locations] = [.kabah, .prophet, .aqsa, .baqi, .ali, .hussain, .reza, .askariain, .masuma, .zainab, .iia, .top, .right, .bottom, .left]
    
    var coordinates: Coordinates {
        switch self {
        //Adhan's coordinates for Kabah: Coordinates(lat: 21.4225241, lon: 39.8261818)
        case .kabah:     return Coordinates(lat: 21.422487, lon: 39.826206)
        case .prophet:   return Coordinates(lat: 24.4707, lon: 39.6307)
        case .aqsa:      return Coordinates(lat: 31.7761, lon: 35.2358)
        case .baqi:      return Coordinates(lat: 24.4672, lon: 39.6138)
        case .ali:       return Coordinates(lat: 31.9957, lon: 44.3148)
        case .hussain:   return Coordinates(lat: 32.6164, lon: 44.0324)
        case .reza:      return Coordinates(lat: 36.2878, lon: 59.6155)
        case .askariain: return Coordinates(lat: 34.19878, lon: 43.87338)
        case .masuma:    return Coordinates(lat: 34.6418, lon: 50.8790)
        case .zainab:    return Coordinates(lat: 33.4444, lon: 36.3409)
            
        case .iia: return Coordinates(lat: 42.3259, lon: -83.2983)
            
        case .top: return Coordinates(lat: 42.3174, lon: -83.4633)
        case .right: return Coordinates(lat: 42.2864, lon: -83.4004)
        case .bottom: return Coordinates(lat: 42.2300, lon: -83.4548)
        case .left: return Coordinates(lat: 42.2860, lon: -83.5431)
        }
    }
    
    var name: String {
        switch self {
        case .kabah:     return "Ka'ba"
        case .prophet:   return "Masjid Al-Nabawi"
        case .aqsa:      return "Masjid Al-Aqsa"
        case .baqi:      return "Baqi'"
        case .ali:       return "Imam Ali Shrine"
        case .hussain:   return "Imam Hussain Shrine"
        case .reza:      return "Imam Ridha Shrine"
        case .askariain: return "Askariain Shrine"
        case .masuma:    return "Sayedah Ma'suma Shrine"
        case .zainab:    return "Sayedah Zainab Shrine"
            
        case .iia: return "Islamic Institute of America"
            
        case .top: return "Top"
        case .right: return "Right"
        case .bottom: return "Bottom"
        case .left: return "Left"
        }
    }
    
    var imageString: String {
        switch self {
        case .kabah:     return "Launch"
        case .prophet:   return "Launch"
        case .aqsa:      return "Launch"
        case .baqi:      return "Launch"
        case .ali:       return "Launch"
        case .hussain:   return "Launch"
        case .reza:      return "Launch"
        case .askariain: return "Launch"
        case .masuma:    return "Launch"
        case .zainab:    return "Launch"
            
        case .iia: return "Launch"
            
        case .top: return "Launch"
        case .right: return "Launch"
        case .bottom: return "Launch"
        case .left: return "Launch"
        }
    }
    
    var compassIconString: String {
        if self == .kabah { return "kaba" }
        else { return "shrine" }
    }
    
}

extension Double {
    var degreesToRadians: Double { return self * .pi / 180 }
    var radiansToDegrees: Double { return self * 180 / .pi }
    
    var metersToMiles: Double { return self / 1609.34 }
    var metersToKilometers: Double { return self / 1000 }
}

extension Float {
    var metersToFeet: Float { return self / 3.28084 }
}
