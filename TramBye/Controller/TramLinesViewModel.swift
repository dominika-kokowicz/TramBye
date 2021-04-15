//
//  TramLinesViewModel.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 30/03/2021.
//

import Foundation
import UIKit

struct TramLinesViewModel {
    
    private var viewModel = MapSceneViewModel()
    private let repository = TramDataRepository.shared
    
    weak var managedViewController: TramLinesViewController?

    var tramLines: [Int] {
        repository.allSeenLines.sorted()
    }
    
    func didSelect(line: String) {
        repository.addSelected(line: line)
    }
    
    func didDeselect(line: String) {
        repository.removeSelected(line: line)
    }
    
    func isLineSelected(_ line: String) -> Bool {
        repository.selectedLines.contains(line)
    }
    
}
