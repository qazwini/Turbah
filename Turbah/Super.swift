//
//  Super.swift
//  Turbah
//
//  Created by MMQ on 7/15/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

let save = UserDefaults.standard

let appURL = "https://apps.apple.com/app/id1523945049"
let developerURL = "https://apps.apple.com/developer/id1510691402"


let blurEffect = UIBlurEffect(style: .systemThinMaterial)

func hapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}
