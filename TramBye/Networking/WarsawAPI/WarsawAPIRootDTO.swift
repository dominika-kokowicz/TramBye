//
//  WarsawApiRoot.swift
//  TramBye
//
//  Created by Dominika Kokowicz on 26/03/2021.
//

import Foundation

struct WarsawAPIRootDTO: Decodable {
    let result: [WarsawAPITramDataDTO]
}
