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
    
    var compassView = CompassView()
    var locationButton = VisualEffectButton()
    var settingsButton = VisualEffectButton()
    
    var locationsView: LocationsListMenu?
    var transparentView: UIView?
    
    var rightImage = UIImageView()
    var leftImage = UIImageView()
    
    var turbahAdded = false
    
    var errorOverlay: ErrorOverlay?
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard AVCaptureDevice.authorizationStatus(for: .video) == .authorized || AVCaptureDevice.authorizationStatus(for: .video) == .notDetermined else { showErrorAlert(type: .camera); return }
        guard requestLocationAuthorization() else { return }
        setupUI()
        initManager()
    }
    
    func setupUI() {
        view = arView
        
        compassView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addRemovePressed)))
        view.addSubview(compassView)
        compassView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        compassView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
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
    
    let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.2, 0.2])
    
    func placeTurbah() {
        guard let turbah = try! Turbah.loadScene().turbah else { print("error"); return }
        
        anchor.addChild(turbah)

        arView.scene.addAnchor(anchor)
        
        print("before", anchor.position)
        print("euler", arView.session.currentFrame!.camera.eulerAngles)
        let cameraAngles = arView.session.currentFrame!.camera.transform.columns.3
        let decreaseValue: Float = 4
        anchor.position.z = (-1.0 / decreaseValue)// + cameraAngles.z
        anchor.position.x = (Float(sin(bearingOfKabah.radiansToDegrees)) / decreaseValue)// + cameraAngles.x
        //anchor.position.y += cameraAngles.y
        print("after", anchor.position)
        
        turbahAdded = true
    }
    
    @objc func addRemovePressed() {
        hapticFeedback()
        if !turbahAdded {
            guard didSendFeedback else {
                compassView.isUserInteractionEnabled = false

                let veBackground = VisualEffectText(effect: blurEffect)
                veBackground.alpha = 0
                view.addSubview(veBackground)
                veBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 71).isActive = true
                veBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                veBackground.title = "Please face the qibla then place"

                UIView.animateKeyframes(withDuration: 4, delay: 0, options: .calculationModeCubic, animations: {
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.05) {
                        veBackground.alpha = 1
                    }
                    UIView.addKeyframe(withRelativeStartTime: 0.95, relativeDuration: 0.05) {
                        veBackground.alpha = 0
                    }
                }, completion: { (completed) in
                    guard completed else { return }
                    veBackground.removeFromSuperview()
                    self.compassView.isUserInteractionEnabled = true
                })

                return
            }
            placeTurbah()
        } else {
            // Remove
            arView.scene.anchors.removeAll()
            turbahAdded = false
        }
    }
    
    @objc func topButtonsClicked(_ sender: UITapGestureRecognizer) {
        hapticFeedback(style: .medium)
        if sender.view?.tag == 0 {
            // Location
            arView.gestureRecognizers?.forEach { $0.cancelsTouchesInView = false }
            
            transparentView = UIView()
            transparentView!.backgroundColor = nil
            let gesture = UITapGestureRecognizer(target: self, action: #selector(transparentViewClicked))
            gesture.cancelsTouchesInView = false
            transparentView!.addGestureRecognizer(gesture)
            view.addSubview(transparentView!)
            transparentView!.fillSuperview()
            
            locationsView = LocationsListMenu()
            locationsView!.rowClicked = { location in
                self.transparentViewClicked()
                self.locationButton.newTitle = location.1
                self.selectedLocation = location.0
            }
            locationsView!.alpha = 0
            view.addSubview(locationsView!)
            NSLayoutConstraint.activate([
                locationsView!.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 5),
                locationsView!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5)
            ])
            view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.2) {
                self.locationsView!.alpha = 1
            }
        } else {
            // Settings
            let navVC = UINavigationController(rootViewController: SettingsVC())
            navVC.navigationBar.prefersLargeTitles = true
            present(navVC, animated: true)
        }
    }
    
    @objc func transparentViewClicked() {
        UIView.animate(withDuration: 0.2, animations: {
            self.locationsView?.alpha = 0
        }) { _ in
            self.locationsView?.removeFromSuperview()
            self.transparentView?.removeFromSuperview()
            self.locationsView = nil
            self.transparentView = nil
            
            self.arView.gestureRecognizers?.forEach { $0.cancelsTouchesInView = true }
        }
    }
    
    
    // MARK: - Qibla Methods
    
    let locationManager = CLLocationManager()
    var bearingOfKabah = Double()
    var distanceOfKabah = Double()
    var selectedLocation: Coordinates = .kabah
    
    func initManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest//NearestTenMeters
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func requestLocationAuthorization() -> Bool {
        locationManager.requestWhenInUseAuthorization()
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse: return true
        case .denied, .restricted:
            showErrorAlert(type: .location)
            return false
        case .notDetermined: return requestLocationAuthorization()
        default: return false
        }
    }
    
    enum errorType {
        case location, camera
    }
    
    func showErrorAlert(type: errorType) {
        errorOverlay = ErrorOverlay()
        errorOverlay!.alpha = 0
        errorOverlay!.message = (type == .location) ? "Location Services disabled" : "Camera permissions disabled"
        errorOverlay!.retryButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeErrorOverlay)))
        view.addSubview(errorOverlay!)
        errorOverlay!.fillSuperview()
        
        UIView.animate(withDuration: 0.2) {
            self.errorOverlay?.alpha = 1
        }
    }
    
    @objc func removeErrorOverlay() {
        hapticFeedback()
        guard requestLocationAuthorization(), AVCaptureDevice.authorizationStatus(for: .video) == .authorized else { return }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.errorOverlay?.alpha = 0
        }) { _ in
            self.errorOverlay?.removeFromSuperview()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        removeErrorOverlay()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        config.worldAlignment = .gravityAndHeading
        arView.session.run(config)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.session.pause()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        distanceOfKabah = locations.last!.distance(from: CLLocation(latitude: selectedLocation.lat, longitude: selectedLocation.lon))
        bearingOfKabah = getBearingBetween(locations.last!, selectedLocation)
    }
    
    func getBearingBetween(_ point1: CLLocation, _ coordinates: Coordinates) -> Double {
        let lat1 = point1.coordinate.latitude.degreesToRadians
        let lon1 = point1.coordinate.longitude.degreesToRadians
        
        let lat2 = coordinates.lat.degreesToRadians
        let lon2 = coordinates.lon.degreesToRadians
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        var radiansBearing = atan2(y, x)
        
        if radiansBearing < 0.0 {
            radiansBearing += 2 * .pi
        }
        
        return radiansBearing
    }
    
    var didSendFeedback = false
    var didAddCoaching = false
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading heading: CLHeading) {
        let chosenHeading = (save.northType == 0) ? heading.magneticHeading : heading.trueHeading
        let north = chosenHeading.degreesToRadians
        let directionOfKabah = north - bearingOfKabah//degreesToRadians(bearingOfKabah) + north
        
        print("qibla degreees:", directionOfKabah.radiansToDegrees)
        
        compassView.kabaImageView.transform = CGAffineTransform(rotationAngle: CGFloat(-directionOfKabah));
        
        compassView.isPointingAtQibla = (directionOfKabah < 0.1 && directionOfKabah > -0.1)
        
        let offAccept = 0.25
        
        if directionOfKabah > offAccept || directionOfKabah < -.pi {
            didSendFeedback = false
            leftImage.alpha = 0
            rightImage.alpha = 1
        } else if directionOfKabah < -offAccept && directionOfKabah > -.pi {
            didSendFeedback = false
            rightImage.alpha = 0
            leftImage.alpha = 1
        } else {
            if !didSendFeedback {
                hapticFeedback(style: .medium)
                if !didAddCoaching { addCoaching() }
                didSendFeedback = true
            }
            leftImage.alpha = 0
            rightImage.alpha = 0
        }
    }
    
    
    // MARK: - AR Coaching
    
    func addCoaching() {
        didAddCoaching = true
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = arView.session
        coachingOverlay.goal = .horizontalPlane
        
        view.addSubview(coachingOverlay)
        coachingOverlay.fillSuperview()
    }
    
    public func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        UIView.animate(withDuration: 0.2) {
            self.compassView.alpha = 0
            self.settingsButton.alpha = 0
            self.locationButton.alpha = 0
            self.transparentViewClicked()
        }
    }
    
    public func coachingOverlayViewDidDeactivate(_ coachingOverlayView: ARCoachingOverlayView) {
        UIView.animate(withDuration: 0.2) {
            self.compassView.alpha = 1
            self.settingsButton.alpha = 1
            self.locationButton.alpha = 1
        }
        
        guard didSendFeedback, selectedLocation == Coordinates.kabah else { return }
        arView.scene.anchors.removeAll()
        placeTurbah()
    }
}
