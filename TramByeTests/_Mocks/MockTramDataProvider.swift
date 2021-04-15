//
//  MockTramDataProvider.swift
//  TramByeTests
//
//  Created by Dominika Kokowicz on 06/04/2021.
//

import Foundation
@testable import TramBye

final class MockTramDataProvider: TramDataProvider {
    var mockSelectedLines: (() -> Set<String>)?
    var selectedLines: Set<String> { mockSelectedLines?() ?? [] }
    
    var mockGetWarsawTramsData: ((([MapData]) -> Void) -> Void)?
    func getWarsawTramsData(_ completion: @escaping ([MapData]) -> Void) {
        mockGetWarsawTramsData?(completion)
    }
}
