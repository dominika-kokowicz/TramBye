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
    @IBOutlet weak var mapView: MKMapView!
   
    @IBAction func changeMapType(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            mapView.mapType = .standard
            chooseTramLinesButton.tintColor = .black
        } else {
            mapView.mapType = .satellite
            chooseTramLinesButton.tintColor = .white
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.managedViewController = self
        
        viewModel.viewDidLoad()
        
        //_ = Timer.scheduledTimer(timeInterval: 11.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)

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
    
//    @objc func fireTimer() {
//        viewModel.getTramsAnnotations()
//        print("Timer reseted")
//    }

}
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
extension MapScreenViewController {
    func showUserLocation() {
        print("🛤", #function, #line)
    }
    
    func hideUserLocation() {
        print("🛤", #function, #line)
    }
    
//    func isUserLocationVisible(isVisible: UserLocationStatus) {
//        print("🛤", #function, #line)
//        switch isVisible {
//        case .visible:
//            mapView.showsUserLocation = true
//        case .hidden:
//            mapView.showsUserLocation = false
//        }
//    }
    
    func displayAlertAskingForLocationPermission() {
        print("🛤", #function, #line)
        
        userLocationHandler.locationManager.requestWhenInUseAuthorization()
    }
    
    func refreshAnnotation(_ annotations: [MapDataAnnotation]) {
        print("🛤", #function, #line, annotations)
        
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


//        for url in chosenTramLinesArray {
//            let result = tramsManager.fetchTramLineLocation2(tramLine: url)
//            urlsOfChosenTramLines.append(result)
//
//        }
//        for urls in urlsOfChosenTramLines {
//            tramsManager.performRequest(urlString: urls)
//        }
