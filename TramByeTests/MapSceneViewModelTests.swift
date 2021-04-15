//
//  TramByeTests.swift
//  TramByeTests
//
//  Created by Dominika Kokowicz on 06/04/2021.
//

import XCTest
@testable import TramBye

final class MapSceneViewModelTests: XCTestCase {
    
    var sut: MapSceneViewModel!
    
    var mockDataProvider: MockTramDataProvider!

    override func setUpWithError() throws {
        mockDataProvider = MockTramDataProvider()
        sut = MapSceneViewModel(dataProvider: mockDataProvider)
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        sut = .none
        mockDataProvider = .none
        try super.tearDownWithError()
    }

    func test_getTramsAnnotations_should_callExternalDependencyForData() throws {
        // Arrange
        let didCallApi = expectation(description: "Did not call external dependency")
        
        mockDataProvider.mockGetWarsawTramsData = { _ in
            didCallApi.fulfill()
        }
        
        // Act
        sut.getTramsAnnotations()
        
        // Assert
        waitForExpectations(timeout: 2.0)
    }

}
