//
//  UIDevice+Extension.swift
//  Turbah
//
//  Created by MMQ on 12/23/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

extension UIDevice {
    
    var hasNotch: Bool {
        return (UIApplication.shared.mainWindow?.safeAreaInsets.bottom ?? 0) > 0
    }
    
}
