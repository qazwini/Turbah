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
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var arView = ARView()
    var placeButton = UIButton()
    
    var locationButton = VisualEffectButton()
    var settingsButton = VisualEffectButton()
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        arView.addCoaching()
        initManager()
    }
    
    func setupUI() {
        view = arView
        
        placeButton.translatesAutoresizingMaskIntoConstraints = false
        placeButton.adjustsImageWhenHighlighted = false
        placeButton.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 60)), for: .normal)
        placeButton.tintColor = .white
        placeButton.addTarget(self, action: #selector(placeTurbah), for: .touchUpInside)
        view.addSubview(placeButton)
        NSLayoutConstraint.activate([
            placeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        
        locationButton.button.setTitle("Ka'ba", for: .normal)
        locationButton.button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        locationButton.tag = 0
        locationButton.button.addTarget(self, action: #selector(topButtonsClicked(_:)), for: .touchUpInside)
        view.addSubview(locationButton)
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5)
        ])
        
        settingsButton.button.setImage(UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)), for: .normal)
        settingsButton.tag = 1
        settingsButton.button.addTarget(self, action: #selector(topButtonsClicked(_:)), for: .touchUpInside)
        view.addSubview(settingsButton)
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
    }
    
    @objc func placeTurbah() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        if placeButton.transform == .identity {
            // Add
            let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.2, 0.2])
            arView.scene.addAnchor(anchor)
            
            let boxAnchor = try! Turbah.loadScene()
            
            // Add the box anchor to the scene
            arView.scene.anchors.append(boxAnchor)
            
            UIView.animate(withDuration: 0.2) {
                self.placeButton.transform = CGAffineTransform(rotationAngle: .pi / 4)
            }
        } else {
            // Remove
            arView.scene.anchors.removeAll()
            UIView.animate(withDuration: 0.2) {
                self.placeButton.transform = .identity
            }
        }
    }
    
    @objc func topButtonsClicked(_ sender: UIButton) {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    
    // MARK: - Qibla Methods
    
    var ivCompassBack = UIView()
    var ivCompassNeedle = UIView()
    
    var selectedLocation: coordinates = .kabah
    
    struct coordinates {
        let lat: Double
        let lon: Double
        
        static let kabah = coordinates(lat: 21.422487, lon: 39.826206)
        
        static let ali = coordinates(lat: 32.6164, lon: 44.0324)
        static let hussain = coordinates(lat: 32.6164, lon: 44.0324)
    }
    
    var location: CLLocation?
    let locationManager = CLLocationManager()
    var bearingOfKabah = Double()
    
    func initManager() {
        locationManager.requestWhenInUseAuthorization()
        guard CLLocationManager.locationServicesEnabled() else { return }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        ivCompassBack.backgroundColor = .red
        ivCompassBack.layer.cornerRadius = 40
        ivCompassNeedle.backgroundColor = .blue
        [ivCompassBack, ivCompassNeedle].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
        ivCompassBack.widthAnchor.constraint(equalToConstant: 80).isActive = true
        ivCompassBack.heightAnchor.constraint(equalToConstant: 80).isActive = true
        ivCompassNeedle.widthAnchor.constraint(equalToConstant: 20).isActive = true
        ivCompassNeedle.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        let toppy = UIView()
        toppy.backgroundColor = .yellow
        toppy.translatesAutoresizingMaskIntoConstraints = false
        ivCompassNeedle.addSubview(toppy)
        toppy.topAnchor.constraint(equalTo: ivCompassNeedle.topAnchor, constant: 3).isActive = true
        toppy.widthAnchor.constraint(equalTo: ivCompassNeedle.widthAnchor, constant: -6).isActive = true
        toppy.heightAnchor.constraint(equalTo: toppy.widthAnchor).isActive = true
        toppy.centerXAnchor.constraint(equalTo: ivCompassNeedle.centerXAnchor).isActive = true
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading heading: CLHeading) {
        let north = -1 * heading.magneticHeading * Double.pi/180
        let directionOfKabah = bearingOfKabah * Double.pi/180 + north
        
        ivCompassBack.transform = CGAffineTransform(rotationAngle: CGFloat(north));
        ivCompassNeedle.transform = CGAffineTransform(rotationAngle: CGFloat(directionOfKabah));
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last!
        bearingOfKabah = getBearingBetweenTwoPoints1(location!, lat: selectedLocation.lat, lon: selectedLocation.lon) //calculating the bearing of KABAH
    }
    
    
    func degreesToRadians(_ degrees: Double) -> Double { return degrees * Double.pi / 180.0 }
    
    func radiansToDegrees(_ radians: Double) -> Double { return radians * 180.0 / Double.pi }
    
    func getBearingBetweenTwoPoints1(_ point1: CLLocation, lat: Double , lon: Double) -> Double {
        let lat1 = degreesToRadians(point1.coordinate.latitude)
        let lon1 = degreesToRadians(point1.coordinate.longitude)
        
        let lat2 = degreesToRadians(lat);
        let lon2 = degreesToRadians(lon);
        
        let dLon = lon2 - lon1;
        
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        var radiansBearing = atan2(y, x);
        
        if radiansBearing < 0.0 {
            radiansBearing += 2 * Double.pi;
        }
        
        return radiansToDegrees(radiansBearing)
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
        coachingOverlay.fillSuperview()
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        //Ready to add entities next?
    }
}
