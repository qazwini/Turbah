//
//  CustomTurbah.swift
//  Turbah
//
//  Created by MMQ on 7/16/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit
import RealityKit

class CustomTurbah: Entity, HasModel, HasAnchoring {
    
    required init(color: UIColor, size: Float) {
        super.init()
        
        let box = MeshResource.generateBox(size: size, cornerRadius: size/4)
        let material = SimpleMaterial(color: color, isMetallic: false)
        
        self.components[ModelComponent] = ModelComponent(
            mesh: box,
            materials: [material]
        )
    }
    
    convenience init(color: UIColor, size: Float, position: SIMD3<Float>) {
        self.init(color: color, size: size)
        self.position = position
    }
    
    required init() { fatalError("init() has not been implemented") }
    
}
