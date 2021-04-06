//
//  MapSceneViewModel.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 26/03/2021.
//

import UIKit
import MapKit

struct MapSceneViewModel {
    
    weak var managedViewController: MapScreenViewController?
    
    let defaults = UserDefaults.standard
    let regionInMeters: Double = 10_000
    
    private let warsawApi = WarsawAPI()
    private let locationHandler = UserLocationHandler()
  
    
    func viewDidLoad() {
        handleUserLocation()
    }
    
    func viewDidAppear() {
        getTramsAnnotations()
        managedViewController?.setUpPublisher()
    }
    
    private func handleUserLocation() {
        print("handle User Location fired")
        switch locationHandler.locationAccesStatus {
        case .granted:
            print("Granted fired")
            //managedViewController?.isUserLocationVisible(isVisible: .case)
            managedViewController?.showUserLocation()
            centerViewOnUserLocation()
            locationHandler.startUpdatingLocation()
            
        case .notDetermined:
            print("Not determined fired")
            managedViewController?.hideUserLocation()
            managedViewController?.displayAlertAskingForLocationPermission()

        case .denied:
            print("Denied fired")
            managedViewController?.hideUserLocation()

        case .disabled:
            print("Disabled fired")
            managedViewController?.hideUserLocation()

        }
    }
    
    func centerViewOnUserLocation() {
        if let location = locationHandler.locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
                managedViewController?.mapView.setRegion(region, animated: true)
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleUserLocation()
    }
    
     func getTramsAnnotations() {
        warsawApi
            .getWarsawTramsData { (mapData: [MapData]) in
                let maped = mapData.map { datum in MapDataAnnotation(mapData: datum) }
                managedViewController?.refreshAnnotation(maped)
                managedViewController?.showUserLocation()
            }
    }
    
    

}

