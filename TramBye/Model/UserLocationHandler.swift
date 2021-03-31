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
    static var locationManager = CLLocationManager()
    
    override init() {
        UserLocationHandler.locationManager = CLLocationManager()
        UserLocationHandler.locationManager.desiredAccuracy = kCLLocationAccuracyBest

        super.init()

        UserLocationHandler.locationManager.delegate = self
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
        UserLocationHandler.locationManager.startUpdatingLocation()
    }
    
private var checkLocationAuthorization: AccessStatus {
        switch UserLocationHandler.locationManager.authorizationStatus {
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


    





