//
//  Location.swift
//  Turbah
//
//  Created by MMQ on 7/17/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import Foundation

enum Locations: CaseIterable {
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
        }
    }
    
    var name: String {
        switch self {
        case .kabah:     return "Kaba".localized
        case .prophet:   return "MasjidAlNabawi".localized
        case .aqsa:      return "MasjidAlAqsa".localized
        case .baqi:      return "Baqi".localized
        case .ali:       return "ImamAliShrine".localized
        case .hussain:   return "ImamHussainShrine".localized
        case .reza:      return "ImamRidhaShrine".localized
        case .askariain: return "AskariainShrine".localized
        case .masuma:    return "SayedahMasumaShrine".localized
        case .zainab:    return "SayedahZainabShrine".localized
        }
    }
    
    var compassIconString: String {
        return self == .kabah ? "kaba" : "shrine"
    }
    
//    var imageString: String {
//        switch self {
//        case .kabah:     return ""
//        case .prophet:   return ""
//        case .aqsa:      return ""
//        case .baqi:      return ""
//        case .ali:       return ""
//        case .hussain:   return ""
//        case .reza:      return ""
//        case .askariain: return ""
//        case .masuma:    return ""
//        case .zainab:    return ""
//        }
//    }
    
}
