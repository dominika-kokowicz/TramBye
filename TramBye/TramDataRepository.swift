//
//  TramDataRepository.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 06/04/2021.
//

import Foundation

final class TramDataRepository {
    static let shared = TramDataRepository()
    static let selectedLinesArray = "selectedLinesArray"
    
    private(set) var chosenTramLinesToTrack = Set<Int>()
    private(set) var urlsOfChosenTramLines = [String]()
    
    private let warsawApi = WarsawAPI()
    private let defaults = UserDefaults.standard
    
    private(set) var allSeenLines: Set<Int> = []
    private(set) var selectedLines: Set<String> = []
    
    private init() {
        loadSelectedLines()
    }
    
    func addSelected(line: String) {
        selectedLines.insert(line)
        print(selectedLines)
        print("Was added, set looks like:\(selectedLines)")

        persistsSelectedLines()
    }
    
    func removeSelected(line: String) {
        selectedLines.remove(line)
        print("Was removed, set looks like:\(selectedLines)")
        persistsSelectedLines()
    }
    
    private func persistsSelectedLines() {
        //defaults.setValue(selectedLines, forKey: TramDataRepository.selectedLinesArray)
    }
    
    private func loadSelectedLines() {
//        if let chosenTramLinesToTrack = defaults.array(forKey: TramDataRepository.selectedLinesArray)
        //chosenTramLinesToTrack = defaults.array(forKey: TramDataRepository.selectedLinesArray)
    }
    
}

extension TramDataRepository: TramDataProvider {
    func getWarsawTramsData(_ completion: @escaping ([MapData]) -> Void) {
        warsawApi.getWarsawTramsData { [weak self] (mapData: [MapData]) in

            mapData.forEach { (datum: MapData) in
                _ = datum
                    .title
                    .flatMap( Int.init )
                    .flatMap{ (i: Int) in self?.allSeenLines.insert(i) }
            }
            
            completion(mapData)
        }
    }
}
