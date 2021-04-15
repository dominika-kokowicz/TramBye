//
//  ViewController.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 13/03/2021.
//

import UIKit
import MapKit
import Combine

class MapScreenViewController: UIViewController {
    
    private var viewModel = MapSceneViewModel()
    private var userLocationHandler = UserLocationHandler()
    private var store = [AnyCancellable]()
    private let TramsOnTheMapIdentifier = "TramsOnTheMap"
    
    @IBOutlet weak var chooseTramLinesButton: UIButton!
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.showsTraffic = true
        }
    }
   
    
// MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.managedViewController = self
        
        viewModel.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
// MARK: - User Interaction

extension MapScreenViewController {
    
     @IBAction func changeMapType(_ sender: UISegmentedControl) {
         
         if sender.selectedSegmentIndex == 0 {
             mapView.mapType = .standard
             chooseTramLinesButton.tintColor = .black
         } else {
             mapView.mapType = .satellite
             chooseTramLinesButton.tintColor = .white
         }
         
     }
}

// MARK: - Timer

extension MapScreenViewController {
    func setUpPublisher() {
        Timer.publish(every: 11.0, tolerance: 1.0, on: .main, in: .default, options: .none)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self!.viewModel.getTramsAnnotations()
                print("Timer reseted")
            }.store(in: &store)
    }
}

// MARK: - User Location

extension MapScreenViewController {
    
    enum UserLocationStatus {
        case visible, hidden
        
        var isVisible: Bool { self == .visible }
    }
    
    func setUserLocation(status: UserLocationStatus) {
        mapView.showsUserLocation = status.isVisible
    }
    
    
    func displayAlertAskingForLocationPermission() {
        print("🛤", #function, #line)
        
        userLocationHandler.locationManager.requestWhenInUseAuthorization()
    }
    
    func refreshAnnotation(_ annotations: [MapDataAnnotation]) {
        mapView.removeAnnotations(mapView.annotations.filter { $0 !== mapView.userLocation })

        mapView.addAnnotations(annotations)
    }
}

extension MapScreenViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard annotation as? MKUserLocation != mapView.userLocation else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: TramsOnTheMapIdentifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: TramsOnTheMapIdentifier)
        } else {
            annotationView?.annotation = annotation
        }
       
        annotationView?.glyphText = annotation.title as? String
        annotationView?.titleVisibility = MKFeatureVisibility.hidden
        return annotationView
    }
   
}
