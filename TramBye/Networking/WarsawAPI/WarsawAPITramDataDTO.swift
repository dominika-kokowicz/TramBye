//
//  WarsawAPITramDataDTO.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 26/03/2021.
//

import Foundation

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
