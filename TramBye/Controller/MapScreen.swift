//
//  ViewController.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 13/03/2021.
//

import UIKit
import MapKit
import CoreLocation

var places: [TramsData] = []

class MapScreenViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
   
    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            mapView.mapType = .standard
        } else {
            mapView.mapType = .satellite
        }
        
    }
    var tramsManager = TramsManager()
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        mapView.showsUserLocation = true
        tramsManager.performRequest(urlString: tramsManager.tramsURL)
        //mapView.addAnnotations(arrayOfTramsLocation)
        
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        //Type of accuracy to choose
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            //Setup our location manager
        } else {
            //Show the user the alert how to turn off localization services across the whole device
        }
    }
    
    func centerViewonUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
            mapView.addAnnotations(places)
            
        }
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        //When app is open
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewonUserLocation()
        //Location Manager starts updating location and fires delegate method in extension (didUpdateLocations)
            locationManager.startUpdatingLocation()
        //You have to show alert instructing how to turn on the permission
        case .denied:
            break
        //You have to ask for permission
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        //Parental control - parents restricted the
        case .restricted:
            //Show alert explaining why it cannot be changed and so on
            break
        //When in background also
        case .authorizedAlways:
            break
     
        @unknown default:
            fatalError()
        }
    }


}

//Conforming to Delegates
extension MapScreenViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    
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
        checkLocationAuthorization()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "TramsOnTheMap") as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "TramsOnTheMap")
        } else {
          annotationView?.annotation = annotation
        }
        annotationView?.glyphText = " 20 "
        
        return annotationView
    }
}


