//
//  TickedSlider.swift
//  Turbah
//
//  Created by MMQ on 7/21/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

class TickedSlider: UISlider {
    
    var pathHeight: CGFloat = 2
    var tickColor: UIColor = UIColor { ($0.userInterfaceStyle == .dark) ? UIColor(hexString: "3D3D42") : UIColor(hexString: "DDDDDD")  }
    var tickWidth: CGFloat = 10

    var trackRect: CGRect {
        return trackRect(forBounds: bounds)
    }
    var pathWidth: CGFloat {
        return bounds.size.width - 2*pathHeight
    }
    var tickDistance: Double {
        return Double(pathWidth) / Double(ticks - 1)
    }
    var ticks: Int {
        return Int(maximumValue - minimumValue) + 1
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: pathHeight), false, 0.0)
        let transparentImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setMaximumTrackImage(transparentImage, for: .normal)
        setMinimumTrackImage(transparentImage, for: .normal)
        
        context?.setFillColor(tickColor.cgColor)
        
        let path = UIBezierPath(rect: trackRect)
        context?.addPath(path.cgPath)
        context?.fillPath()
        
        // Draw Ticks
        
        context?.setFillColor(tickColor.cgColor)
        
        for index in 1...ticks {
            let x = CGFloat(Double(index - 1) * tickDistance)
            let y = bounds.midY - CGFloat(8 / 2)
            let stepPath = UIBezierPath(rect: CGRect(x: x + pathHeight/2, y: y, width: 2, height: 8))

            context?.addPath(stepPath.cgPath)
            context?.fillPath()
        }
    }
}
