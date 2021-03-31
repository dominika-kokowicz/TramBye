//
//  TramLinesViewModel.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 30/03/2021.
//

import Foundation

struct TramLinesViewModel {
    private var viewModel = MapSceneViewModel()
    private let warsawAPI = WarsawAPI()
    
    weak var managedViewController: TramLinesViewController?

    let tramLines = [1,2,3,4,6,7,9,10,11,13,14,15,17,18,20,22,23,24,25,26,27,28,31,33,35,41]
    
    func viewWillDisappear() {
        warsawAPI.generateURLsFromUserArray(userArray: Array(chosenTramLinesToTrack))
    }
    
}
