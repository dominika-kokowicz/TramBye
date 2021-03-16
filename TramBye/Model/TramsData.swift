//
//  TramsData.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 15/03/2021.
//

import Foundation
import CoreLocation
import MapKit

struct Result: Decodable {
    let result: [TramsData]
    
    func numberOfTrams() -> Int {
        return result.count
    }
}

class TramsData: NSObject, Decodable {
    let Lines: String
    let Lon: Double
    let Lat: Double
    
    init(Lat: Double, Lon: Double, Lines: String) {
        self.Lon = Lon
        self.Lat = Lat
        self.Lines = Lines
        
        super.init()
    }
}

extension TramsData: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocation(latitude: Lat, longitude: Lon).coordinate
        }
    }
    
    var title: String? {
        get {
            return Lines
        }
    }
    
}


