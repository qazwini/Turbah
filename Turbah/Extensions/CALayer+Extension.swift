//
//  CALayer+Extension.swift
//  Turbah
//
//  Created by MMQ on 12/23/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

extension CALayer {
    
    func roundCorners(radius: CGFloat = 15, corners: UIRectCorner = .allCorners) {
        let roundPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = roundPath.cgPath
        self.mask = maskLayer
    }
    
}
