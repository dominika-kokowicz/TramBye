//
//  MapDataAnnotation.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 26/03/2021.
//

import Foundation
import MapKit

final class MapDataAnnotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let title: String?
    
    init(mapData: MapData) {
        coordinate = mapData.coordinate
        title = mapData.title
    }
    
}
