//
//  TramsManager.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 14/03/2021.
//

import Foundation
import CoreLocation
import MapKit

struct WarsawAPI {
    
    private var getAllTrams: String {
        "https://api.um.warszawa.pl/api/action/busestrams_get/?resource_id=f2e5503e-%20927d-4ad3-9500-4ab9e55deb59&apikey=\(apiKeyTram)&type=2"
    }
    
    func getWarsawTramsData(_ completion: @escaping ([MapData]) -> Void) {
        URLSession.shared
            .dataTask(with: URLRequest(url: URL(string:getAllTrams)! ) )  { (data, response, error) in
                let decoder = JSONDecoder()
                guard
                    let data = data,
                    let root = try? decoder.decode(WarsawAPIRootDTO.self, from: data)
                else { return }
                
                let mapped: [MapData] = root
                    .result
                    .map { (dto: WarsawAPITramDataDTO) -> MapData in
                        MapData(
                            coordinate: CLLocationCoordinate2DMake(dto.lat, dto.lon),
                            title: dto.lines
                        )
                    }
                
                DispatchQueue.main.async {
                    completion( mapped )
                }
            }
            .resume()
    }
    
}
