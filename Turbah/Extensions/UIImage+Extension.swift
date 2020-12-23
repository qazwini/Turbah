//
//  UIImage+Extension.swift
//  Turbah
//
//  Created by MMQ on 12/23/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit

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
