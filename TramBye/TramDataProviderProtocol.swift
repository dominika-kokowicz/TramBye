//
//  TramDataProvider.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 15/04/2021.
//

import Foundation

protocol TramDataProvider {
    var selectedLines: Set<String> { get }
    func getWarsawTramsData(_ completion: @escaping ([MapData]) -> Void)
}
