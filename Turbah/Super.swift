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

var blurEffect: UIBlurEffect {
    return UIBlurEffect(style: .systemThinMaterial)
}

extension UIView {
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
}


extension UITableViewCell {
    static let cellID = "cellID"
}


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


extension UIView {

    var screenshot: UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }

}


extension UIDevice {
    var hasNotch: Bool {
        return (UIApplication.shared.mainWindow?.safeAreaInsets.bottom ?? 0) > 0
    }
}

extension UIApplication {
    var mainWindow: UIWindow? {
        return UIApplication.shared.windows.first { $0.isKeyWindow }
    }
}


func hapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}


extension UIImage {
    
    func invertedMaskImage() -> UIImage? {
        guard let inputMaskImage = CIImage(image: self),
            let backgroundImageFilter = CIFilter(name: "CIConstantColorGenerator", parameters: [kCIInputColorKey: CIColor.black]),
            let inputColorFilter = CIFilter(name: "CIConstantColorGenerator", parameters: [kCIInputColorKey: CIColor.clear]),
            let inputImage = inputColorFilter.outputImage,
            let backgroundImage = backgroundImageFilter.outputImage,
            let filter = CIFilter(name: "CIBlendWithAlphaMask", parameters: [kCIInputImageKey: inputImage, kCIInputBackgroundImageKey: backgroundImage, kCIInputMaskImageKey: inputMaskImage]),
            let filterOutput = filter.outputImage,
            let outputImage = CIContext().createCGImage(filterOutput, from: inputMaskImage.extent) else { return nil }
        return UIImage(cgImage: outputImage)
    }
    
}


extension UIColor {
    
    class var theme: UIColor {
        return UIColor(hexString: "261F6B")
    }
    
    convenience init(hexString: String, withAlpha alpha: CGFloat = 1.0) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (r, g, b) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
            print("error with color")
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: alpha)
    }
    
}
