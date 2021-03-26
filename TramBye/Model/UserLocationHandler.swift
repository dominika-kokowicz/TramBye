//
//  UserLocationHandler.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 26/03/2021.
//

import Foundation
import CoreLocation

final class UserLocationHandler: NSObject {
    let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        super.init()

        locationManager.delegate = self
    }
    
    enum AccessStatus {
        case granted
        case notDetermined
        case denied
        case disabled
    }
    
    var locationAccesStatus: AccessStatus {
        CLLocationManager.locationServicesEnabled()
            ? checkLocationAuthorization
            : .disabled
    }
    
    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    private var checkLocationAuthorization: AccessStatus {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            return .granted
            
        case .denied:
            return .denied
            
        case .notDetermined:
            return .notDetermined
            
        case .restricted:
            return .disabled

        case .authorizedAlways:
            return .granted
            
        @unknown default:
            return .disabled
        }
    }

}

extension UserLocationHandler: CLLocationManagerDelegate {
    //Code to run when the location of the user changes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        //If the concition location = locations.last is not met nothing will happen below
//        guard let location = locations.last else { return }
//        //We're getting the last known user's location so we get center where the last time he was and we center the map
//        let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//        //We tell how wide we want the map to circulate around the user's location, so called the region
//        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//        mapView.setRegion(region, animated: true)
    }
    
    //Code to run when the authorization is being changed
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        checkLocationAuthorization()
    }
}




