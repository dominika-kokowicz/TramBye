//
//  MapSceneViewModel.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 26/03/2021.
//

import Foundation

struct MapSceneViewModel {
    
    weak var managedViewController: MapScreenViewController?
    
    let defaults = UserDefaults.standard
    let regionInMeters: Double = 10000
    
    
    private let warsawApi = WarawAPI()
    private let locationHandler = UserLocationHandler()
    
    func viewDidLoad() {
        handleUserLocation()
        
    }
    
    func viewDidAppear() {
        getTramsAnnotations()
    }
    
    private func handleUserLocation() {
        switch locationHandler.locationAccesStatus {
        case .granted:
            managedViewController?.showUserLocation()
            
        case .notDetermined:
            managedViewController?.displayAlertAskingForLocationPermission()
            
        case .denied:
            managedViewController?.hideUserLocation()

        case .disabled:
            managedViewController?.hideUserLocation()
        }
    }
    
    private func getTramsAnnotations() {
        warsawApi
            .getWarsawTramsData { (mapData: [MapData]) in
                let maped = mapData.map { datum in MapDataAnnotation(mapData: datum) }
                managedViewController?.refreshAnnotation(maped)
            }
    }
}
