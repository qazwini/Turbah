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
    
    var buttonMargins: CGSize {
        return UIDevice.current.hasNotch ? CGSize(width: 14, height: 0) : CGSize(width: 5, height: 5)
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard AVCaptureDevice.authorizationStatus(for: .video) == .authorized || AVCaptureDevice.authorizationStatus(for: .video) == .notDetermined else { showErrorAlert(type: .camera); return }
        guard requestLocationAuthorization() else { return }
        setupUI()
        showCalibrateView()
        initManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if didAddCoaching { arView.run() }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arView.pause()
    }
    
    func setupUI() {
        view = arView
        
        compassView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(redoRun)))
        view.addSubview(compassView)
        compassView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        compassView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        
        locationButton.title = "Ka'ba"
        locationButton.tag = 0
        locationButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topButtonsClicked(_:))))
        view.addSubview(locationButton)
        locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: buttonMargins.height).isActive = true
        locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: buttonMargins.width).isActive = true
        
        settingsButton.image = UIImage(systemName: "gear", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold))
        settingsButton.tag = 1
        settingsButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(topButtonsClicked(_:))))
        view.addSubview(settingsButton)
        settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: buttonMargins.height).isActive = true
        settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -buttonMargins.width).isActive = true
        
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
    
    let anchor = AnchorEntity(plane: .horizontal)
    
    func placeTurbah() {
        guard let turbah = try! Turbah.loadScene().turbah else { print("error"); return }
        anchor.addChild(turbah)
        arView.scene.addAnchor(anchor)
        
        let cameraAngles = arView.session.currentFrame!.camera.transform.columns.3
        
        let decreaseValue = 6 - save.distance
        
        anchor.position.z = -1 * cos(Float(bearingOfKabah)) / decreaseValue + cameraAngles.z
        anchor.position.x = sin(Float(bearingOfKabah)) / decreaseValue + cameraAngles.x
        // Is Y adjustment needed?
        //anchor.position.y += cameraAngles.y
        print("after", anchor.position)
        
        let x = sin(Float(bearingOfKabah)) / decreaseValue + cameraAngles.z
        let z = -1 * cos(Float(bearingOfKabah)) / decreaseValue + cameraAngles.x
        
        print("angle", atan(x/z) * 180 / .pi)
        
        let anchorAngles = anchor.transform.matrix.columns.3
        
        print("""
        
        camera:   \(cameraAngles)
        anchor:   \(anchorAngles)
        distance: \(length(cameraAngles - anchorAngles) / 3.28084) feet
        
        """)
        
        turbahAdded = true
    }
    
    @objc private func redoRun() {
        hapticFeedback()
        guard save.didRerunTutorial else {
            save.didRerunTutorial = true
            let alert = UIAlertController(title: "Tap to rerun", message: "Tapping this button will calibrate then place the turbah.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        guard didSendFeedback else {
            guard selectedLocation == .kabah else { return }
            
            compassView.isUserInteractionEnabled = false

            let veBackground = VisualEffectText(effect: blurEffect)
            veBackground.alpha = 0
            view.addSubview(veBackground)
            veBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 71).isActive = true
            veBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            veBackground.title = "Please face the Qibla then tap"

            UIView.animateKeyframes(withDuration: 3, delay: 0, options: .calculationModeCubic, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/15) {
                    veBackground.alpha = 1
                }
                UIView.addKeyframe(withRelativeStartTime: 14/15, relativeDuration: 1/15) {
                    veBackground.alpha = 0
                }
            }, completion: { completed in
                guard completed else { return }
                veBackground.removeFromSuperview()
                self.compassView.isUserInteractionEnabled = true
            })

            return
        }
        if !didAddCoaching { addCoaching() }
        arView.run()
    }
    
    @objc func addRemovePressed() {
        hapticFeedback()
        if !turbahAdded {
            // Insert
            guard didSendFeedback else {
                guard selectedLocation == .kabah else { return }
                
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
                }, completion: { completed in
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
            locationsView!.didSelectNewLocation = { location in
                self.transparentViewClicked()
                self.locationButton.newTitle = location.name
                self.selectedLocation = location
                self.compassView.location = location
                
                self.arView.scene.anchors.removeAll()
                self.turbahAdded = false
            }
            locationsView!.alpha = 0
            view.addSubview(locationsView!)
            locationsView!.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 5).isActive = true
            locationsView!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: buttonMargins.width).isActive = true
            
            UIView.animate(withDuration: 0.2) {
                self.locationsView!.alpha = 1
            }
        } else {
            // Settings
            arView.pause()
            let settingsVC = SettingsVC()
            settingsVC.didEnterMainView = { self.arView.run() }
            let navVC = UINavigationController(rootViewController: settingsVC)
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
            
            // FIXME: Remove this but make sure nothing is ruined
            //self.arView.gestureRecognizers?.forEach { $0.cancelsTouchesInView = true }
        }
    }
    
    
    // MARK: - First Time Compass Turotial
    
    var calibrateView: CalibrateView?
    
    func showCalibrateView() {
        guard !save.didShowCalibration else { return }
        save.didShowCalibration = true
        
        calibrateView = CalibrateView()
        calibrateView!.alpha = 0
        calibrateView!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeCalibrateView)))
        
        view.addSubview(calibrateView!)
        calibrateView!.centerInSuperview()
        calibrateView!.widthAnchor.constraint(equalToConstant: 273).isActive = true
        
        UIView.animate(withDuration: 0.2, delay: 0.5, options: [], animations: {
            self.calibrateView?.alpha = 1
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.removeCalibrateView()
            }
        }
    }
    
    @objc func removeCalibrateView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.calibrateView?.alpha = 0
        }) { _ in
            self.calibrateView?.removeFromSuperview()
            self.calibrateView = nil
        }
    }
    
    
    // MARK: - Qibla Methods
    
    let locationManager = CLLocationManager()
    var bearingOfKabah = Double()
    var distanceOfKabah = Double()
    var selectedLocation: Locations = .kabah
    
    func initManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest//NearestTenMeters
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func requestLocationAuthorization() -> Bool {
        guard CLLocationManager.locationServicesEnabled() else { showErrorAlert(type: .location); return false }
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse: return true
        case .denied, .restricted:
            showErrorAlert(type: .location)
            return false
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return true
        default: return false
        }
    }
    
    enum errorType { case location, camera }
    
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
        switch CLLocationManager.authorizationStatus() {
        case .denied, .restricted: showErrorAlert(type: .location)
        default: break
        }
        removeErrorOverlay()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        distanceOfKabah = locations.last!.distance(from: CLLocation(latitude: selectedLocation.coordinates.lat, longitude: selectedLocation.coordinates.lon))
        bearingOfKabah = getBearingBetween(locations.last!, selectedLocation.coordinates)
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
        let chosenHeading = save.trueNorth ? heading.trueHeading : heading.magneticHeading
        let north = chosenHeading.degreesToRadians
        let directionOfKabah = north - bearingOfKabah
        
        //print("qibla degreees:", directionOfKabah.radiansToDegrees)
        //print("phone", arView.session.currentFrame?.camera.transform.columns.3 ?? "")
        //print("anchor", anchor.transform.matrix.columns.3)
        //print("")
        
        compassView.kabaImageView.transform = CGAffineTransform(rotationAngle: CGFloat(-directionOfKabah));
        compassView.isPointingAtQibla = (directionOfKabah < 0.1 && directionOfKabah > -0.1)
        
        let offAccept = 0.25
        
        if -directionOfKabah > offAccept || -directionOfKabah < -.pi {
            didSendFeedback = false
            leftImage.alpha = 0
            rightImage.alpha = 1
        } else if -directionOfKabah < -offAccept && -directionOfKabah > -.pi {
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
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = arView.session
        coachingOverlay.goal = .horizontalPlane
        
        view.addSubview(coachingOverlay)
        coachingOverlay.fillSuperview()
        
        arView.run()
    }
    
    public func coachingOverlayViewWillActivate(_ coachingOverlayView: ARCoachingOverlayView) {
        didAddCoaching = true
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
        
        guard didSendFeedback, selectedLocation == .kabah else { return }
        placeTurbah()
    }
}


fileprivate extension ARView {
    
    func run() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        config.worldAlignment = .gravityAndHeading //save.trueNorth ? .gravityAndHeading : .gravity
        session.run(config, options: [.removeExistingAnchors, .resetTracking])
    }
    
    func pause() {
        session.pause()
    }
    
}
