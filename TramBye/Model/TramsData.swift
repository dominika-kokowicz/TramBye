//
//  TramsData.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 15/03/2021.
//

import Foundation

struct Result: Decodable {
    let result: [TramsData]
    
    func numberOfTrams() -> Int {
        return result.count
    }
}

struct TramsData: Decodable {
    let Lines: String
    let Lon: Double
    let Lat: Double
}
