//
//  UIApplication+Extension.swift
//  Turbah
//
//  Created by MMQ on 12/23/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

extension UIApplication {
    
    var mainWindow: UIWindow? {
        return UIApplication.shared.windows.first { $0.isKeyWindow }
    }
    
}
