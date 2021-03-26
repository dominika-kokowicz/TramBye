//
//  TramsData.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 15/03/2021.
//

import Foundation
import CoreLocation
import MapKit


// NETWORKING

struct WarsawAPITramDataDTO: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case lines = "Lines"
        case lon = "Lon"
        case lat = "Lat"
    }
    
    let lines: String
    let lon: Double
    let lat: Double
}

struct WarsawApiRoot: Decodable {
    let result: [WarsawAPITramDataDTO]
}



//
// [API] <--> Interface <-->
//

// APP

struct MapData {
    let coordinate: CLLocationCoordinate2D
    let title: String?
}

final class MapDataAnnotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let title: String?
    
    init(mapData: MapData) {
        coordinate = mapData.coordinate
        title = mapData.title
    }
    
}

// ----

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


