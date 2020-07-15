//
//  ViewController.swift
//  Turbah
//
//  Created by MMQ on 7/15/20.
//  Copyright © 2020 MMQ. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController {
    
    var arView = ARView()
    var placeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        arView.addCoaching()
        
        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.2, 0.2])
        arView.scene.addAnchor(anchor)
        
        let boxAnchor = try! Turbah.loadScene()
        
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
    }
    
    func setupUI() {
        view = arView
        
        placeButton.translatesAutoresizingMaskIntoConstraints = false
        placeButton.backgroundColor = .white
        placeButton.layer.cornerRadius = 40
        placeButton.addTarget(self, action: #selector(placeTurbah), for: .touchUpInside)
        view.addSubview(placeButton)
        NSLayoutConstraint.activate([
            placeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            placeButton.heightAnchor.constraint(equalToConstant: 80),
            placeButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    @objc func placeTurbah() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

extension ARView: ARCoachingOverlayViewDelegate {
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = self.session
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(coachingOverlay)
        NSLayoutConstraint.activate([
            coachingOverlay.topAnchor.constraint(equalTo: topAnchor),
            coachingOverlay.trailingAnchor.constraint(equalTo: trailingAnchor),
            coachingOverlay.bottomAnchor.constraint(equalTo: bottomAnchor),
            coachingOverlay.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        //Ready to add entities next?
    }
}
