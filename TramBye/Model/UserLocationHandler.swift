//
//  UserLocationHandler.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 26/03/2021.
//

import Foundation
import CoreLocation
import MapKit

final class UserLocationHandler: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    
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


    





