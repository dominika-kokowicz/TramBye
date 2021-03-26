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
    func getWarsawTramsData(_ completion: ([MapData]) -> Void) {
        completion([])
    }
}






struct TramsManager {
    let tramsURL = "https://api.um.warszawa.pl/api/action/busestrams_get/?resource_id=%20f2e5503e-%20927d-4ad3-9500-4ab9e55deb59&apikey=\(apiKeyTram)&type=2&line=20"
    
    func fetchTramLineLocation(tramLine: String) {
        let urlString = "\(tramsURL)=\(tramLine)#"
        print(urlString)
    }
    
    func performRequest(urlString: String) {
        //Create a URL
        if let url = URL(string: urlString) {
            //Create a URLSession
            let session = URLSession(configuration: .default)
            //Give a session the task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(tramsData: safeData)
                }
                
            }
            //Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(tramsData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Result.self, from: tramsData)
            let numberOfTrams = decodedData.result.count
            
            for (index, element) in decodedData.result.enumerated() {
                //print(index, ":", element)
               
                places.append(TramsData(Lat: decodedData.result[index].Lat, Lon: decodedData.result[index].Lon, Lines: decodedData.result[index].Lines))
                
                
               
            }
            
        } catch {
            print(error)
        }
    }
    
}
