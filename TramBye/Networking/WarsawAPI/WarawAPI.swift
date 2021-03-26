//
//  TramsManager.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 14/03/2021.
//

import Foundation
import CoreLocation
import MapKit

struct WarawAPI {
    private let tramsURL = "https://api.um.warszawa.pl/api/action/busestrams_get/?resource_id=%20f2e5503e-%20927d-4ad3-9500-4ab9e55deb59&apikey=\(apiKeyTram)&type=2&line=20"

    func getWarsawTramsData(_ completion: @escaping ([MapData]) -> Void) {
        URLSession.shared
            .dataTask(with: URLRequest(url: URL(string: tramsURL)! ) )  { (data, response, error) in
                let decoder = JSONDecoder()
                let root = try! decoder.decode(WarsawApiRootDTO.self, from: data!)
                
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
