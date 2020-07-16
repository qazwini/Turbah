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

class ViewController: UIViewController, CLLocationManagerDelegate, ARCoachingOverlayViewDelegate {
    
    var arView = ARView()
    var placeButtonView = UIVisualEffectView()
    
    var locationButton = VisualEffectButton()
    var settingsButton = VisualEffectButton()
    
    var rightImage = UIImageView()
    var leftImage = UIImageView()
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addCoaching()
        initManager()
    }
    
    func setupUI() {
        view = arView
        
        let effect = UIBlurEffect(style: .systemThinMaterial)
        placeButtonView.effect = effect
        placeButtonView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(placeTurbah)))
        placeButtonView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(placeButtonView)
        NSLayoutConstraint.activate([
            placeButtonView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            placeButtonView.widthAnchor.constraint(equalToConstant: 60),
            placeButtonView.heightAnchor.constraint(equalToConstant: 60)
        ])
        placeButtonView.layer.masksToBounds = true
        placeButtonView.layer.cornerRadius = 30
        
        let vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: effect, style: .secondaryLabel))
        placeButtonView.contentView.addSubview(vibrancyView)
        vibrancyView.fillSuperview()
        
        let verticalLine = UIView()
        let horizontalLine = UIView()
        [verticalLine, horizontalLine].forEach {
            $0.backgroundColor = .black
            $0.layer.cornerRadius = 2
            $0.translatesAutoresizingMaskIntoConstraints = false
            vibrancyView.contentView.addSubview($0)
            $0.centerInSuperview()
        }
        NSLayoutConstraint.activate([
            verticalLine.widthAnchor.constraint(equalToConstant: 4),
            verticalLine.heightAnchor.constraint(equalToConstant: 32),
            horizontalLine.widthAnchor.constraint(equalToConstant: 32),
            horizontalLine.heightAnchor.constraint(equalToConstant: 4)
        ])
        
        locationButton.title = "Ka'ba"
        locationButton.tag = 0
        locationButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topButtonsClicked(_:))))
        view.addSubview(locationButton)
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5)
        ])
        
        settingsButton.image = UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold))
        settingsButton.tag = 1
        settingsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topButtonsClicked(_:))))
        view.addSubview(settingsButton)
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5)
        ])
        
        rightImage.image = UIImage(systemName: "chevron.compact.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .medium))
        leftImage.image = UIImage(systemName: "chevron.compact.left", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .medium))
        [rightImage, leftImage].forEach {
            $0.tintColor = .white
            $0.alpha = 0
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        rightImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        leftImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
    }
    
    @objc func placeTurbah() {
        hapticFeedback()
        if placeButtonView.transform == .identity {
            // Add
            let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.2, 0.2])
            arView.scene.addAnchor(anchor)
            
            let boxAnchor = try! Turbah.loadScene()
            
            // Add the box anchor to the scene
            arView.scene.anchors.append(boxAnchor)
            
            UIView.animate(withDuration: 0.2) {
                self.placeButtonView.transform = CGAffineTransform(rotationAngle: .pi / 4)
            }
        } else {
            // Remove
            arView.scene.anchors.removeAll()
            UIView.animate(withDuration: 0.2) {
                self.placeButtonView.transform = .identity
            }
        }
    }
    
    @objc func topButtonsClicked(_ sender: UITapGestureRecognizer) {
        hapticFeedback(style: .medium)
        if sender.view?.tag == 0 {
            // Location
        } else {
            // Settings
            let navVC = UINavigationController(rootViewController: SettingsVC())
            navVC.navigationBar.prefersLargeTitles = true
            present(navVC, animated: true)
        }
    }
    
    
    // MARK: - Qibla Methods
    
    var ivCompassBack = UIView()
    var ivCompassNeedle = UIView()
    
    var selectedLocation: coordinates = .kabah
    
    struct coordinates {
        let lat: Double
        let lon: Double
        
        static let kabah = coordinates(lat: 21.422487, lon: 39.826206)
        static let aqsa = coordinates(lat: 31.7761, lon: 35.2358)
        static let prophet = coordinates(lat: 24.4707, lon: 39.6307)
        static let ali = coordinates(lat: 31.9957, lon: 44.3148)
        static let hussain = coordinates(lat: 32.6164, lon: 44.0324)
        static let reza = coordinates(lat: 36.2878, lon: 59.6155)
        static let askariain = coordinates(lat: 34.19878, lon: 43.87338)
        static let baqi = coordinates(lat: 24.4672, lon: 39.6138)
        static let masuma = coordinates(lat: 34.6418, lon: 50.8790)
        static let zainab = coordinates(lat: 33.4444, lon: 36.3409)
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
        
        if directionOfKabah > 0.2 || directionOfKabah < -.pi {
            didSendFeedback = false
            leftImage.alpha = 0
            rightImage.alpha = 1
        } else if directionOfKabah < -0.2 && directionOfKabah > -.pi {
            didSendFeedback = false
            rightImage.alpha = 0
            leftImage.alpha = 1
        } else {
            if !didSendFeedback {
                hapticFeedback(style: .medium)
                didSendFeedback = true
            }
            leftImage.alpha = 0
            rightImage.alpha = 0
        }
    }
    
    var didSendFeedback = false
    
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
    
    
    // MARK: - AR Coaching
    
    func addCoaching() {
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = arView.session
        coachingOverlay.goal = .horizontalPlane
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(coachingOverlay)
        coachingOverlay.fillSuperview()
    }
    
    public func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        UIView.animate(withDuration: 0.2) {
            self.settingsButton.alpha = 0
            self.locationButton.alpha = 0
        }
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        UIView.animate(withDuration: 0.2) {
            self.settingsButton.alpha = 1
            self.locationButton.alpha = 1
        }
    }
}
