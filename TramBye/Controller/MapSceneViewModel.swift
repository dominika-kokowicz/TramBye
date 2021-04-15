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
    let dataProvider: TramDataProvider
    
    private let locationHandler = UserLocationHandler()
    
    init(dataProvider: TramDataProvider = TramDataRepository.shared) {
        self.dataProvider = dataProvider
    }
  
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
            managedViewController?.setUserLocation(status: .visible)
            centerViewOnUserLocation()
            locationHandler.startUpdatingLocation()
            
        case .notDetermined:
            print("Not determined fired")
            managedViewController?.setUserLocation(status: .hidden)
            managedViewController?.displayAlertAskingForLocationPermission()

        case .denied:
            print("Denied fired")
            managedViewController?.setUserLocation(status: .hidden)

        case .disabled:
            print("Disabled fired")
            managedViewController?.setUserLocation(status: .hidden)

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
        dataProvider
            .getWarsawTramsData { (mapData: [MapData]) in
                let maped = mapData
                    .filter{ (datum: MapData) -> Bool in
                        datum.title.map( dataProvider.selectedLines.contains )
                        ?? false
                    }
                    .map { datum in MapDataAnnotation(mapData: datum) }
                managedViewController?.refreshAnnotation(maped)
                managedViewController?.setUserLocation(status: .visible)
            }
    }
}

